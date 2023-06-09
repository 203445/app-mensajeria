part of 'users_bloc.dart';

abstract class UsersState {}

class InitialState extends UsersState {}

class Loading extends UsersState {}

class LoadedPage extends UsersState {}

class VerifiedUser extends UsersState {
  final bool response;
  VerifiedUser({required this.response});
}

class UserCreated extends UsersState {
  final User user;
  UserCreated({required this.user});
}

class Logged extends UsersState {
  final String logged;
  Logged({required this.logged});
}

class Error extends UsersState {
  final String error;
  Error({required this.error});
}