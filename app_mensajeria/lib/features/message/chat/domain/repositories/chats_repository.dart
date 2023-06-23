import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'dart:io';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

abstract class ChatsRepository {
  Future<List<Chats>> getChats();
  Future<void> createChats(ChatModel chats);
  Future<void> sendMessage(String chatId, String message, int type, String userId);
  Future<List<ChatModel>> getMessage(String chatId);
  Future<String> uploadMedia(String path, File file);
}
