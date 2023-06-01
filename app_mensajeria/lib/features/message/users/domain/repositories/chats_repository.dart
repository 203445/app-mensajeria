import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

abstract class ChatsRepository {
  Future<List<Chats>> getChats();
  Future<List<Chats>> deleteChats();
  Future<List<Chats>> addChats();
}
