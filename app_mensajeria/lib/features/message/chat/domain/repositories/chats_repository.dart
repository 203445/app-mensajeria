import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'dart:io';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

abstract class ChatsRepository {
  Future<List<Chats>> getChats(String id);
  Future<String?> getChatId(String userEmisor,String userReceptor);
  Future<void> createChats(String userEmisor,String userReceptor);
  Future<void> sendMessage(String chatId, String message, int type, String userId);
  Future<List<ChatModel>> getMessage(String chatId);
  Future<String> uploadMedia(String path, File file);
}
