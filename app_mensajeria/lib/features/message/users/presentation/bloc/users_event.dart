part of 'users_bloc.dart';

abstract class UsersEvent {}

class SendMesssage extends UsersEvent {
  final String phone;

  SendMesssage({required this.phone});
}

class SendVerification extends UsersEvent {
  final String id;
  final String code;

  SendVerification({required this.id, required this.code});
}

class GetNotes extends UsersEvent {}

// class AddUser extends UsersEvent {
//   final List<User> users;

//   AddNotes({required this.notes});
// }

// class UpdateNote extends NotesEvent {
//   final Note note;

//   UpdateNote({required this.note});
// }

// class DeleteNote extends NotesEvent {
//   final Note note;

//   DeleteNote({required this.note});
// }

//class GetNotesOffline extends NotesEvent {}