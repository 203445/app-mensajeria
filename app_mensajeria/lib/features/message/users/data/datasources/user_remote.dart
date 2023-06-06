import 'dart:convert' as convert;
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart' as entitie;
import 'package:app_mensajeria/features/message/users/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final auth = FirebaseAuth.instance;

abstract class UserRemoteDataSource {
  Future<bool> sendMessage(String phone);
  Future<bool> verifyCode(String id, String code);
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
  Future<bool> sendMessage(String phone) async {
    late bool sent = false;
    auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          print(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          sent = true;
        },
        codeAutoRetrievalTimeout: (e) {
          print(e.toString());
        });
    return sent;
  }

  @override
  Future<bool> verifyCode(String id, String code) async {
    late bool verificated = false;
    final credential = PhoneAuthProvider.credential(verificationId: id, smsCode: code);
    try {
      await auth.signInWithCredential(credential);
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
