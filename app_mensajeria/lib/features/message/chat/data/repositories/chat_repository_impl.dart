import 'dart:io';
import 'package:app_mensajeria/features/message/chat/data/datasources/chat_remote_data_source.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';


import '../models/chats_model.dart';

class ChatRepositoryImpl implements ChatsRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl({required this.chatRemoteDataSource});

  @override
  Future<List<ChatModel>> getChats(String id) async {
    return await chatRemoteDataSource.getChats(id);
  }

  @override
  Future<String?> getChatId(String userEmisor, String userReceptor) async {
    return await chatRemoteDataSource.getChatId(userEmisor, userReceptor);
  }

  @override
  Future<void> createChats(String userEmisor, String userReceptor) async {
    return await chatRemoteDataSource.createChat(userEmisor, userReceptor);
  }

  @override
  Future<void> sendMessage(
      String chatId, String message, int type, String userId) async {
    return await chatRemoteDataSource.sendMessage(
        chatId, message, type, userId);
  }

  @override
  Future<List<ChatModel>> getMessage(String chatId) async {
    return await chatRemoteDataSource.getMessage(chatId);
  }

  @override
  Future<String> uploadMedia(String path, File file) async {
    return await chatRemoteDataSource.uploadMedia(path, file);
  }
}
