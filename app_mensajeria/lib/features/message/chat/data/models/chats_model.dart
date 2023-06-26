import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chats {
  ChatModel({
    required String userEmisorId,
    required String userReceptorId,
   
    required Map<String, dynamic> messages,
  }) : super(
          userEmisorId: userEmisorId,
          userReceptorId: userReceptorId,
          messages: messages,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      userEmisorId: json['userEmisorId'],
      userReceptorId: json['userReceptorId'],
      
      messages: json['messages'],
    );
  }

  factory ChatModel.fromEntity(Chats chats) {
    return ChatModel(
      userEmisorId:
          chats.userEmisorId, // Establece el ID del emisor correctamente
      userReceptorId:
          chats.userReceptorId, // Establece el ID del receptor correctamente
      messages: chats
          .messages, // Puedes establecer mensajes vacíos o manejarlos de otra manera
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'userId': userId,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      // 'timestamp': timestamp,
      // 'type': type
    };
  }

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic>? messagesData = data['messages'];

    List<Map<String, dynamic>> messages = [];
    if (messagesData != null) {
      messages = messagesData.cast<Map<String, dynamic>>();
    }

    return ChatModel(
      userEmisorId: data['userEmisorId'],
      userReceptorId: data['userReceptorId'],
      messages: messages.isNotEmpty ? messages.first : {},
    );
  }

  static MessageType _mapIntToMessageType(int type) {
    switch (type) {
      case 0:
        return MessageType.text;
      case 1:
        return MessageType.image;
      case 2:
        return MessageType.audio;
      case 3:
        return MessageType.video;
      case 4:
        return MessageType.gif;
      default:
        return MessageType.unknown;
    }
  }


  // factory ChatModel.fromDocument(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   // print(data);
  //   // return data;
  //   // final String messagesData = data['messages'];
  //   final List<dynamic>? messagesData = data['messages'];

  //   List<String> messages = [];
  //   if (messagesData != null) {
  //     messages = messagesData.map((message) => message.toString()).toList();
  //   }

  //   return ChatModel(
  //     // userId: doc.id,
  //     // userId: data  ['userId'],
  //     userEmisorId: data['userEmisorId'],
  //     userReceptorId: data['userReceptorId'],
  //     messages: messages,
  //     // // timestamp: data['timestamp'],
  //     // type: data['type'] != null
  //     //     ? _mapIntToMessageType(data['type'] as int)
  //     //     : MessageType.unknown,
  //   );
  // }
}
