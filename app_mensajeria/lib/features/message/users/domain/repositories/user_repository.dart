import 'dart:io';

import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

abstract class UserRepository { 
  Future<bool> verifyExistence(String email);
  Future <User?> createProfile(String name, String data, File? img, String email, String password);
  Future <bool> addContact(String email, String id);
  Future <List<User>> getContacts(String id);
  Future <bool> updateProfile(String id, String name, String data, File? img);
  Future <User?> getUser(String id);
}