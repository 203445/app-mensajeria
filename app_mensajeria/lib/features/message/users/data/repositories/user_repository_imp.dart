import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/data/datasources/user_remote.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp({required this.userRemoteDataSource});

  @override
  Future<bool> sendMessage(String phone) async {
    return await userRemoteDataSource.sendMessage(phone);
  }

  @override
  Future<bool> verifyCode(String id, String code) async {
    return await userRemoteDataSource.verifyCode(id, code);
  }

  @override
  Future<User?> getUserbyPhone(String phone) async {
    return await userRemoteDataSource.getUserbyPhone(phone);
  }

  @override
  Future<User> createProfile(User user) async {
    return await createProfile(user);
  }
}