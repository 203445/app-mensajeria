import 'dart:io';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/data/datasources/user_remote.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp({required this.userRemoteDataSource});

  @override
  Future<bool> verifyExistence(String email) async {
    return await userRemoteDataSource.verifyExistence(email);
  }

  @override
  Future<User?> createProfile(String name, String data, File? img, String email,
      String password) async {
    return await userRemoteDataSource.createProfile(
        name, data, img, email, password);
  }

  @override
  Future<bool> addContact(String email, String id) async {
    return await userRemoteDataSource.addContact(email, id);
  }

  @override
  Future<List<User>> getContacts(String id) async {
    return await userRemoteDataSource.getContacts(id);
  }

  @override
  Future<bool> updateProfile(
      String id, String name, String data, File? img) async {
    return await userRemoteDataSource.updateProfile(id, name, data, img);
  }

  @override
  Future<User?> getUser(String id) async {
    return await userRemoteDataSource.getUser(id);
  }

  @override
  Future<User?> getFireId(String idFirebase) async {
    return await userRemoteDataSource.getFireId(idFirebase);
  }
}
