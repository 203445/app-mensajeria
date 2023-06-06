import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

abstract class UserRepository {
  Future <bool> sendMessage(String phone);
  Future <bool> verifyCode(String id, String code);
  Future <User?> getUserbyPhone(String phone);
  Future <User> createProfile(User user);
  // Future <List<User>> getContacts(List<String> phones);
  // Future <void> logOut(String phone);
  // Future <void> updateProfile(User user);
  // Future <void> deleteUser(String phone);
}