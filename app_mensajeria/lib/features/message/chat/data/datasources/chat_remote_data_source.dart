import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<void> createChat(ChatModel chat);
  Future<void> sendMessage(String chatId, String message);
  Future<List<Map<String, dynamic>>> getMessage(String chatId);
}

class ChatRemoteDataSourceImp implements ChatRemoteDataSource {
  final CollectionReference _chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  @override
  Future<List<ChatModel>> getChats() async {
    final snapshot = await _chatsCollection.get();
    final chatsList =
        snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
    return chatsList;
  }

  @override
  Future<void> createChat(ChatModel chat) async {
    final chatData = chat.toMap();
    await _chatsCollection.doc().set(chatData);
  }

  @override
  Future<void> sendMessage(String chatId, String message) async {
    final chatRef = _chatsCollection.doc(chatId);
    final newMessage = {'message': message};
    await chatRef.update({
      'messages': FieldValue.arrayUnion([newMessage])
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getMessage(String chatId) async {
    final chatRef = _chatsCollection.doc(chatId);
    final snapshot = await chatRef.get();
    final chatData = snapshot.data() as Map<String, dynamic>?;
    if (chatData != null && chatData.containsKey('messages')) {
      final messages = chatData['messages'] as List<dynamic>;
      return messages.cast<Map<String, dynamic>>();
    }
    return [];
  }
}
