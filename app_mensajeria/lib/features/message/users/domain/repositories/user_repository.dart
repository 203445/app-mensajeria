import 'dart:io';

import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

abstract class UserRepository { 
  Future<bool> verifyExistence(String email);
  Future <User?> createProfile(String name, String data, File img, String email, String password);
  Future <bool> addContact(String email, String id);
  Future <void> getContacts(String id);
  // Future <void> logOut(String phone);
  // Future <void> updateProfile(User user);
  // Future <void> deleteUser(String phone);
}