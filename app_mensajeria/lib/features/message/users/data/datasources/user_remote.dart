import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart'
    as ent;
import 'package:app_mensajeria/features/message/users/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final auth = FirebaseAuth.instance;
final dio = Dio();

String apiURI =
    'https://b7fd-177-244-61-246.ngrok-free.app';

abstract class UserRemoteDataSource {
  Future<bool> verifyExistence(String email);
  Future<ent.User?> createProfile(
      String name, String data, File img, String email, String password);
  Future <bool> addContact(String email, String id);
  Future <List<ent.User>> getContacts(String id);

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
  Future<ent.User?> createProfile(
    String name, String data, File img, String email, String password) async {
    late String firebaseId;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebaseId = userCredential.user!.uid.toString();
      print(firebaseId);

      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "data": data,
        "img": await MultipartFile.fromFile(img.path, filename: img.path.split("/").last),
        "isLoged": "True",
        "firebaseId": firebaseId,
      });

      final response = await dio.post("$apiURI/users/db/", data: formData);
      if (response.statusCode == 200){
        return ent.User(id: response.data['id'].toString(), name: response.data['name'].toString(), data: response.data['data'].toString(), img: response.data['img'].toString(), firebaseId: response.data['firebaseId'].toString());
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
    final response = await dio.post("$apiURI/users/contacts/$id", data: formData);

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<List<ent.User>> getContacts(String id) async {
    final response = await dio.get("$apiURI/users/contactsList/$id",);

    if (response.statusCode == 200) {
      List<ent.User> contactsList = [];
      var contacts = response.data['contacts'];

      if (contacts.length > 0) {
        for (var object in contacts) {
          contactsList.add(ent.User(id: object['id'].toString(), name: object['name'].toString(), data: object['data'].toString(), img: object['img'].toString(), firebaseId: object['firebaseId'].toString()));
        }
      }
      return contactsList;   
    }
    return [];
  }
  
}
