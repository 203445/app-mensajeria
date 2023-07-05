import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'package:app_mensajeria/features/message/users/domain/entities/users.dart'
    as ent;
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final dio = Dio();

String apiURI = 'https://a60e-187-188-32-68.ngrok-free.app';

Future<File> getImageFileFromAssets() async {
  const String path = "images/default-user.png";
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

abstract class UserRemoteDataSource {
  Future<bool> verifyExistence(String email);
  Future<ent.User?> createProfile(
      String name, String data, File? img, String email, String password);
  Future<bool> addContact(String email, String id);
  Future<List<ent.User>> getContacts(String id);
  Future<bool> updateProfile(String id, String name, String data, File? img);
  Future<ent.User?> getUser(String id);
  Future<ent.User?> getFireId(String idFirebase);
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  @override
  Future<bool> verifyExistence(String email) async {
    FormData formData = FormData.fromMap({
      "email": email,
    });
    final response = await dio.get("$apiURI/users/db/", data: formData);

    return response.data;
  }

  @override
  Future<ent.User?> createProfile(String name, String data, File? img,
      String email, String password) async {
    late String firebaseId;
    FormData formData;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebaseId = userCredential.user!.uid.toString();

      if (img != null) {
        formData = FormData.fromMap({
          "name": name,
          "email": email,
          "password": password,
          "data": data,
          "img": await MultipartFile.fromFile(img.path,
              filename: img.path.split("/").last),
          "isLoged": "True",
          "firebaseId": firebaseId,
        });
      } else {
        final File defaultImg = await getImageFileFromAssets();
        formData = FormData.fromMap({
          "name": name,
          "email": email,
          "password": password,
          "data": data,
          "img": await MultipartFile.fromFile(defaultImg.path,
              filename: defaultImg.path.split("/").last),
          "isLoged": "True",
          "firebaseId": firebaseId,
        });
      }

      final response = await dio.post("$apiURI/users/db/", data: formData);
      if (response.statusCode == 200) {
        return ent.User(
            id: response.data['id'].toString(),
            name: response.data['name'].toString(),
            data: response.data['data'].toString(),
            img: response.data['img'].toString(),
            firebaseId: response.data['firebaseId'].toString());
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<bool> addContact(String email, String id) async {
    FormData formData = FormData.fromMap({
      "email": email,
    });
    final response =
        await dio.post("$apiURI/users/contacts/$id", data: formData);

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<List<ent.User>> getContacts(String id) async {
    final response = await dio.get(
      "$apiURI/users/contactsList/$id",
    );

    if (response.statusCode == 200) {
      List<ent.User> contactsList = [];
      var contacts = response.data['contacts'];

      if (contacts.length > 0) {
        for (var object in contacts) {
          contactsList.add(ent.User(
              id: object['id'].toString(),
              name: object['name'].toString(),
              data: object['data'].toString(),
              img: object['img'].toString(),
              firebaseId: object['firebaseId'].toString()));
        }
      }
      return contactsList;
    }
    return [];
  }

  @override
  Future<bool> updateProfile(
      String id, String name, String data, File? img) async {
    FormData formData;

    if (img != null) {
      formData = FormData.fromMap({
        "name": name,
        "data": data,
        "img": await MultipartFile.fromFile(img.path,
            filename: img.path.split("/").last),
      });
    } else {
      formData = FormData.fromMap({
        "name": name,
        "data": data,
      });
    }

    final response = await dio.put("$apiURI/users/$id", data: formData);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<ent.User?> getUser(String id) async {
    final response = await dio.get("$apiURI/users/$id");

    if (response.statusCode == 200) {
      return (ent.User(
          id: response.data['id'].toString().toString(),
          name: response.data['name'].toString(),
          data: response.data['data'].toString(),
          img: response.data['img'].toString(),
          firebaseId: response.data['firebaseId'].toString()));
    }

    return null;
  }

  @override
  Future<ent.User?> getFireId(String idFirebase) async {
    FormData formData = FormData.fromMap({
      "firebaseId": idFirebase,
    });
    final response = await dio.get("$apiURI/users/fire/", data: formData);

    if (response.statusCode == 200) {
      return (ent.User(
          id: response.data['id'].toString().toString(),
          name: response.data['name'].toString(),
          data: response.data['data'].toString(),
          img: response.data['img'].toString(),
          firebaseId: response.data['firebaseId'].toString()));
    }

    return null;
  }
}
