import 'dart:convert' as convert;
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart' as entitie;
import 'package:app_mensajeria/features/message/users/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/phone_verification_page.dart';

final auth = FirebaseAuth.instance;

abstract class UserRemoteDataSource {
  String? sendMessage(String phone);
  bool verifyCode(String id, String code);
  Future <entitie.User?> getUserbyPhone(String phone);
  Future <entitie.User> createProfile(entitie.User user);
  // Future <List<User>> getContacts(List<String> phones);
  // Future <void> logOut(String phone);
  // Future <void> createUser(User user);
  // Future <void> updateUser(User user);
  // Future <void> deleteUser(String phone);
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  @override
  String? sendMessage(String phone) {
    late String? verificationID;
    late bool verificated = false;

     auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          print(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          print("\nFUNCIONAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n");
          verificationID = verificationId;
          verificated = true;
        },
        codeAutoRetrievalTimeout: (e) {
          print(e.toString());
        });

    if (verificated){
      return verificationID;
    }
    else {
      return "none";
    }
  }

  @override
  bool verifyCode(String id, String code) {
    late bool verificated = false;
    final credential = PhoneAuthProvider.credential(verificationId: id, smsCode: code);
    try {
      auth.signInWithCredential(credential);
      verificated = true;
    } catch (e) {
      print(e);
    }
    return verificated;
  }

  @override
  Future<entitie.User?> getUserbyPhone(String phone) {
    // TODO: implement getUserbyPhone
    throw UnimplementedError();
  }

  @override
  Future<entitie.User> createProfile(entitie.User user) {
    // TODO: implement createProfile
    throw UnimplementedError();
  }
}
