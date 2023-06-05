import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

abstract class UserRepository {
  Future <User> getUserbyPhone(String phone);
  Future <List<User>> getContacts(List<String> phones);
  Future <void> sendMessage(String phone);
  Future <void> logOut(String phone);
  Future <void> logIn(String phone);
  Future <void> createUser(User user);
  Future <void> updateUser(User user);
  Future <void> deleteUser(String phone);
}