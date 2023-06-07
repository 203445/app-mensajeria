import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

abstract class ChatsRepository {
  Future<List<Chats>> getChats();
  Future<void> createChats( ChatModel chats);
  Future<void> sendMessage(String chatId, String message);
  Future<List<Map<String, dynamic>>> getMessage(String chatId);

}