import 'dart:io';

import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats(String id);
  Future<void> createChat(String userEmisor, String userReceptor);
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

  // @override
  // Future<List<ChatModel>> getChats() async {
  //   final snapshot = await _chatsCollection.get();
  //   final chatsList =
  //       snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
  //   print(chatsList);
  //   return chatsList;
  // }

  @override
  Future<List<ChatModel>> getChats(String id) async {
    final snapshot = await _chatsCollection.get();

    List<ChatModel> chatsList = [];
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic>? messagesData = data['messages'];

      String lastMessageContent = '';
      String lastMessageTimestamp = '';

      if (messagesData != null && messagesData.isNotEmpty) {
        final lastMessage = messagesData.last;
        lastMessageContent = lastMessage['content'] ?? '';
        lastMessageTimestamp = lastMessage['timestamp'] ?? '';
      }

      final userEmisorId = data['userEmisorId'];
      final userReceptorId = data['userReceptorId'];

      // Verificar si el ID coincide con userEmisorId o userReceptorId
      if (userEmisorId == id || userReceptorId == id) {
        final chat = ChatModel(
          userEmisorId: userEmisorId,
          userReceptorId: userReceptorId,
          messages: {
            'content': lastMessageContent,
            'timestamp': lastMessageTimestamp,
          },
        );

        chatsList.add(chat);
      }
    }
    return chatsList;
  }

  // List chats = [];

  // CollectionReference collectionReferenceChats = db.collection('chat');

  // QuerySnapshot querychats = await collectionReferenceChats.get();

  // for (var doc in querychats.docs) {
  //   final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   final id = doc.id;

  //   final chat = {
  //     'userEmisorId': data['userEmisorId'],
  //     'id': doc.id,
  //     'userReceptorId': data['userReceptorId'],
  //   };
  //   CollectionReference collectionReferenceMessages =
  //       db.collection('chat').doc(id).collection('messagess');
  //   QuerySnapshot querymessages = await collectionReferenceMessages.get();

  //   for (var doc in querymessages.docs) {
  //     final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //     final chat2 = {
  //       'messages': data['messages'],
  //       'userId': data['userId'],
  //       'timestamp': data['timestamp'],
  //       'type': data['type'],
  //     };

  //     final mergedChat = {};
  //     mergedChat.addAll(chat);
  //     mergedChat.addAll(chat2);
  //     chats.add(mergedChat);
  //     print(chats);
  //   }
  // }
  // // }

  // // return chats.map<ChatModel>((data) => ChatModel.fromJson(data)).toList();
  // // return chats.map<ChatModel>((data) => ChatModel.fromJson(data)).toList();
  // return chats
  //     .map<ChatModel>(
  //         (data) => ChatModel.fromJson(Map<String, dynamic>.from(data)))
  //     .toList();

  // return chats
  //     .map<ChatModel>(
  //         (data) => ChatModel.fromJson(data as Map<String, dynamic>))
  // .toList();
  // }
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
  Future<void> createChat(String userEmisor, String userReceptor) async {
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
        'userEmisorId': userEmisor,
        'userReceptorId': userReceptor,
        'messages': [],
      });
    }
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
  // final chatRef = _chatsCollection.doc(chatId).collection('messages');
  // QuerySnapshot querySnapshot =
  //     await chatRef.orderBy('timestamp', descending: false).get();
  // List<ChatModel> messages = [];

  // for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //   Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;
  //   List<dynamic> messageList = data?['messages'];

  //   ChatModel chat = ChatModel(
  //     userEmisorId: data['userEmisor'],
  //     userReceptorId: data['userReceptor'],
  //     messages: messageList,
  //   );

  //   messages.add(chat);
  // }

  // return messages;
  // final document = await _chatsCollection.doc(chatId).get();

  // if (document.exists) {
  //   final data = document.data() as Map<String, dynamic>;
  //   final List<dynamic>? messagesData = data['messages'];

  //   Map<String, dynamic> messages =
  //       [] as Map<String, dynamic>; // Cambiado de nullable a una lista vacía

  //   if (messagesData != null && messagesData.isNotEmpty) {
  //     messages = messagesData
  //         .map((messageData) => messageData['content']
  //             as String?) // Asegurarse de que el contenido sea de tipo String
  //         .where((message) =>
  //             message != null) // Eliminar los mensajes nulos, si los hay
  //         .cast<
  //             String>() as Map<String,
  //         dynamic>; // Asegurarse de que los elementos sean de tipo String
  //     // .toList();
  //   }

  //   final chat = ChatModel(
  //     userEmisorId: data['userEmisorId'],
  //     userReceptorId: data['userReceptorId'],
  //     messages: messages,
  //   );

  //   return [chat]; // Devuelve una lista con un solo elemento
  // } else {
  //   return []; // Documento no encontrado
  // }
  // }

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


// final chatRef = _chatsCollection.doc(chatId).collection('messagess');
    // final snapshot = await chatRef.get();
    // final chatData = snapshot.docChanges;

    // print(chatData);

    // if (chatData != null && chatData.containsKey('messages')) {
    //   final messagesData = chatData['messages'] as List<dynamic>;
    //   final List<Message> messages = [];

    //   for (var value in messagesData) {
    //     final int messageType = value['type'];
    //     final dynamic messageContent = value['content'];

    //     final MessageType type = _getTypeFromValue(messageType);

    //     if (type != MessageType.unknown) {
    //       final String representation =
    //           _getRepresentation(type, messageContent);
    //       messages.add(Message(type: type, content: representation));
    //     }
    //   }

    //   return messages;
    // }

    // return [];
    // List messages = [];
    // CollectionReference collectionReferenceGames =
    //     db.collection('chats').doc(chatId).collection('messages');

    // QuerySnapshot queryGames = await collectionReferenceGames.get();

    // for (var doc in queryGames.docs) {
    //   final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //   final chat = {
    //     'messages': data['messages'],
    //     'timestamp': data['timestamp'],
    //     'type': data['type'],
    //     'userId': data['userId']
    //   };

    //   messages.add(chat);
    // }
    // return messages
    //     .map<ChatModel>(
    //         (data) => ChatModel.fromJson(Map<String, dynamic>.from(data)))
    //     .toList();

    // final snapshot = await _chatsCollection.get();

    // List<ChatModel> chatsList = [];
    // for (var doc in snapshot.docs) {
    //   final data = doc.data() as Map<String, dynamic>;
    //   final List<dynamic>? messagesData = data['messages'];

    //   String lastMessageContent = '';
    //   String lastMessageTimestamp = '';

    //   if (messagesData != null && messagesData.isNotEmpty) {
    //     final lastMessage = messagesData.last;
    //     lastMessageContent = lastMessage['content'] ?? '';
    //     lastMessageTimestamp = lastMessage['timestamp'] ?? '';
    //   }

    //   final chat = ChatModel(
    //     userEmisorId: data['userEmisorId'],
    //     userReceptorId: data['userReceptorId'],
    //     messages: {
    //       'content': lastMessageContent,
    //       'timestamp': lastMessageTimestamp,
    //     },
    //   );

    //   chatsList.add(chat);
    // }
    // return chatsList;