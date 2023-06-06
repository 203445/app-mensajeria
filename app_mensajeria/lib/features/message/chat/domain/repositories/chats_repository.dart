import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

abstract class ChatsRepository {
  Future<List<Chats>> getChats();
  Future<void> createChats( Chats chats);
  Future<void> deleteChats(String id);
}