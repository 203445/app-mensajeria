part of 'users_bloc.dart';

abstract class UsersEvent {}

class PageNavegation extends UsersEvent {}

class Register extends UsersEvent {
  final String email;
  final String password;

  Register({required this.email, required this.password});
}

class AddContact extends UsersEvent {
  final String email;
  final String id;

  AddContact({required this.email, required this.id});
}

class GetContacts extends UsersEvent {
  final String id;

  GetContacts({required this.id});
}

class CreateProfile extends UsersEvent {
  final String email;
  final String password;
  final String name;
  final String data;
  final File? img;

  CreateProfile(
      {required this.email,
      required this.password,
      required this.name,
      required this.data,
      required this.img});
}
