import 'dart:io';

import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<void> createChat(ChatModel chat);
  Future<void> sendMessage(String chatId, String message, int type);
  Future<List<Message>> getMessage(String chatId);
  Future<String> uploadMedia(String path, File file);
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
  Future<void> sendMessage(String chatId, String message, int type) async {
    final chatRef = _chatsCollection.doc(chatId);
    await chatRef.update({
      'messages': FieldValue.arrayUnion([message])
    });
  }

  Future<List<Message>> getMessage(String chatId) async {
    final chatRef = _chatsCollection.doc(chatId);
    final snapshot = await chatRef.get();
    final chatData = snapshot.data() as Map<String, dynamic>?;

    if (chatData != null && chatData.containsKey('messages')) {
      final messagesData = chatData['messages'] as List<dynamic>;
      final List<Message> messages = [];

      messagesData.forEach((value) {
        final int messageType = chatData['type'];
        final String messageContent = value.toString();
        final MessageType type = _getTypeFromValue(messageType);

        if (type != MessageType.unknown) {
          messages.add(Message(type: type, content: messageContent));
        }
      });

      return messages;
    }

    return [];
  }

  MessageType _getTypeFromValue(int value) {
    switch (value) {
      case 0:
        return MessageType.text;
      case 1:
        return MessageType.image;
      case 2:
        return MessageType.video;
      case 3:
        return MessageType.audio;
      case 4:
        return MessageType.gif;
      default:
        return MessageType.unknown;
    }
  }

  @override
  Future<String> uploadMedia(String path, File file) async {
    Reference reference = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = reference.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
}
