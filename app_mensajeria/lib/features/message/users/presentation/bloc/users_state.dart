part of 'users_bloc.dart';

abstract class UsersState {}

class InitialState extends UsersState {}

//class Updating extends UsersState {}

//class Updated extends UsersState{}

class Loading extends UsersState {}

class LoadedMsg extends UsersState {
  final String response;
  LoadedMsg({required this.response});
}

class VerifiedPhone extends UsersState {
  final bool response;
  VerifiedPhone({required this.response});
}

class Error extends UsersState {
  final String error;
  Error({required this.error});
}