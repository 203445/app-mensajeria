import 'package:app_mensajeria/features/message/chat/data/datasources/chat_remote_data_source.dart';
// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chats_model.dart';

class ChatRepositoryImpl implements ChatsRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Future<List<ChatModel>> getChats() async {
    return await chatRemoteDataSource.getChats();
  }

  @override
  Future<void> createChats(ChatModel chat) async {
    return await chatRemoteDataSource.createChat(chat);
  }

  @override
  Future<void> sendMessage(String chatId, String message) async {
    return await chatRemoteDataSource.sendMessage(chatId, message);
  }

  @override
  Future<List<Map<String, dynamic>>> getMessage(String chatId) async {
    return await chatRemoteDataSource.getMessage(chatId);
  }
}
