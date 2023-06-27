part of 'users_bloc.dart';

abstract class UsersState {}

class InitialState extends UsersState {}

class Loading extends UsersState {}

class LoadedPage extends UsersState {}

class LoadedContacts extends UsersState {
  final List<User> contacts;
  LoadedContacts({required this.contacts});
}

class LoadedChats extends UsersState {
  final List<User> contacts;
  LoadedChats({required this.contacts});
}

class LoadedUser extends UsersState {
  final User user;
  LoadedUser({required this.user});
}

class VerifiedUser extends UsersState {
  final bool response;
  VerifiedUser({required this.response});
}

class UserCreated extends UsersState {
  final User user;
  UserCreated({required this.user});
}

class UserEdited extends UsersState {
  final User user;
  UserEdited({required this.user});
}

class Logged extends UsersState {
  final String logged;
  Logged({required this.logged});
}

class Error extends UsersState {
  final String error;
  Error({required this.error});
}
