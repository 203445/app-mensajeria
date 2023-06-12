import 'dart:io';

import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<void> createChat(ChatModel chat);
  Future<void> sendMessage(String chatId, Message message, int type);
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
  Future<void> sendMessage(String chatId, Message message, int type) async {
    final chatRef = _chatsCollection.doc(chatId);
    final messageData = {
      'content': message.content,
      'type': type,
    };
    await chatRef.update({
      'messages': FieldValue.arrayUnion([messageData])
    });
  }

  @override
  Future<List<Message>> getMessage(String chatId) async {
    final chatRef = _chatsCollection.doc(chatId);
    final snapshot = await chatRef.get();
    final chatData = snapshot.data() as Map<String, dynamic>?;

    if (chatData != null && chatData.containsKey('messages')) {
      final messagesData = chatData['messages'] as List<dynamic>;
      final List<Message> messages = [];

      for (var value in messagesData) {
        final int messageType = value['type'];
        final dynamic messageContent = value['content'];

        final MessageType type = _getTypeFromValue(messageType);

        if (type != MessageType.unknown) {
          final String representation =
              _getRepresentation(type, messageContent);
          messages.add(Message(type: type, content: representation));
        }
      }

      return messages;
    }

    return [];
  }

  String _getRepresentation(MessageType type, dynamic content) {
    if (type == MessageType.text) {
      return content.toString(); // Mostrar el texto directamente
    } else if (type == MessageType.image) {
      return 'Imagen: $content'; // Mostrar un mensaje indicando que es una imagen
    } else if (type == MessageType.gif) {
      return 'GIF: $content'; // Mostrar un mensaje indicando que es un GIF
    } else if (type == MessageType.audio) {
      return 'Audio: $content'; // Mostrar un mensaje indicando que es un audio
    } else if (type == MessageType.video) {
      return 'Video: $content'; // Mostrar un mensaje indicando que es un video
    } else {
      return 'Mensaje desconocido'; // Mostrar un mensaje por defecto para tipos de mensaje desconocidos
    }
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
