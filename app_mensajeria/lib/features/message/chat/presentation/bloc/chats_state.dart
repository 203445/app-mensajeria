part of 'chats_bloc.dart';
  
abstract class ChatState {}

class ChatLoading extends ChatState {}

// class LoadedPage extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chats> chats;
  ChatLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String errorMessage;

  ChatError(this.errorMessage);
}
