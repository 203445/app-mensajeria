import 'dart:io';
import 'dart:convert';

import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats(String id);
  Future<List<ChatModel>> createChat(String userEmisor, String userReceptor);
  Future<String?> getChatId(String userEmisor, String userReceptor);
  Future<void> sendMessage(
      String chatId, String message, int type, String userId);
  Future<List<ChatModel>> getMessage(String chatId);
  Future<String> uploadMedia(String path, File file);
}

class ChatRemoteDataSourceImp implements ChatRemoteDataSource {
  final CollectionReference _chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<ChatModel>> getChats(String id) async {
    final snapshot = await _chatsCollection.get();

    List<ChatModel> chatsList = [];
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic>? messagesData = data['messages'];

      String lastMessageContent = '';
      String lastMessageTimestamp = '';
      String type = '';

      if (messagesData != null && messagesData.isNotEmpty) {
        final lastMessage = messagesData.last;
        lastMessageContent = lastMessage['content'] ?? '';
        lastMessageTimestamp = lastMessage['timestamp'] ?? '';
        type = lastMessage['type'].toString() ?? '';
      }

      final userEmisorId = data['userEmisorId'];
      final userReceptorId = data['userReceptorId'];
      final chatId = doc.id;

      // Verificar si el ID coincide con userEmisorId o userReceptorId
      if (userEmisorId == id || userReceptorId == id) {
        final chat = ChatModel(
          id: chatId,
          userEmisorId: userEmisorId,
          userReceptorId: userReceptorId,
          messages: {
            'content': lastMessageContent,
            'timestamp': lastMessageTimestamp,
            'type': type
          },
        );

        chatsList.add(chat);
      }
    }
    return chatsList;
  }

  @override
  Future<String?> getChatId(String userEmisorId, String userReceptorId) async {
    final querySnapshot = await _chatsCollection
        .where('userEmisorId', isEqualTo: userEmisorId)
        .where('userReceptorId', isEqualTo: userReceptorId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final chatId = querySnapshot.docs[0].id;
      return chatId;
    }

    return null;
  }

  @override
  Future<List<ChatModel>> createChat(
      String userEmisor, String userReceptor) async {
    String generateGroupId(String userEmisor, String userReceptor) {
      // Ordena los IDs de los usuarios alfabéticamente para garantizar consistencia
      List<String> sortedIds = [userEmisor, userReceptor]..sort();

      // Concatena los IDs de los usuarios en un formato específico
      String groupId = sortedIds.join('_');

      return groupId;
    }

    // Genera el groupId para el chat entre los dos usuarios
    String groupId = generateGroupId(userEmisor, userReceptor);

    // Verifica si el chat ya existe usando el groupId como identificador único
    final chatDoc = await _chatsCollection.doc(groupId).get();
    if (!chatDoc.exists) {
      // Si el chat no existe, crea un nuevo documento para el chat
      await _chatsCollection.doc(groupId).set({
        'id': groupId,
        'userEmisorId': userEmisor,
        'userReceptorId': userReceptor,
        'messages': {},
      });
    }

    // Crea una instancia de ChatModel con los valores deseados
    ChatModel chat = ChatModel(
      id: groupId,
      userEmisorId: userEmisor,
      userReceptorId: userReceptor,
      messages: {},
    );

    // Retorna una lista que contiene el objeto ChatModel
    return [chat];
  }

  @override
  Future<void> sendMessage(
      String chatId, String message, int type, String userId) async {
    final chatRef = _chatsCollection.doc(chatId);
    final messageData = {
      'content': message,
      'type': type,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'userId': userId,
    };
    await chatRef.update({
      'messages': FieldValue.arrayUnion([messageData])
    });
  }

  @override
  Future<List<ChatModel>> getMessage(String chatId) async {
    final document = await _chatsCollection.doc(chatId).get();

    if (document.exists) {
      final data = document.data() as Map<String, dynamic>;
      final List<dynamic>? messagesData = data['messages'];

      List<ChatModel> chatList = [];

      if (messagesData != null && messagesData.isNotEmpty) {
        for (var messageData in messagesData) {
          if (messageData['content'] != null) {
            final chat = ChatModel(
              id: data['id'],
              userEmisorId: data['userEmisorId'],
              userReceptorId: data['userReceptorId'],
              messages: {
                '${messageData['key']}': {
                  'content': messageData['content'],
                  'type': messageData['type'],
                  'timestamp': messageData['timestamp'],
                  'userId': messageData['userId'],
                },
              },
            );

            chatList.add(chat);
          }
        }

        // Ordenar la lista por timestamp en orden ascendente
        chatList.sort((a, b) => a.messages.values.first['timestamp']
            .compareTo(b.messages.values.first['timestamp']));

        print(chatList);
        return chatList;
      }
    }

    return []; // Documento no encontrado o mensajes vacíos
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
