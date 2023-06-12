import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chats {
  ChatModel({
    required String id,
    required String userEmisorId,
    required String userReceptorId,
    required List<Message> messages,
    required String timestamp,
    required MessageType type,
  }) : super(
            id: id,
            userEmisorId: userEmisorId,
            userReceptorId: userReceptorId,
            messages: messages,
            timestamp: timestamp,
            type: type);

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['id'],
        userEmisorId: json['userEmisorId'],
        userReceptorId: json['userReceptorId'],
        messages: List<Message>.from(json['messages']),
        timestamp: json['timestamp'],
        type: json['type']);
  }

  factory ChatModel.fromEntity(Chats chats) {
    return ChatModel(
        id: '', // Establece el valor correcto del ID del chat
        userEmisorId:
            chats.userEmisorId, // Establece el ID del emisor correctamente
        userReceptorId:
            chats.userReceptorId, // Establece el ID del receptor correctamente
        messages: [], // Puedes establecer mensajes vacíos o manejarlos de otra manera
        timestamp: chats.timestamp,
        type: chats.type);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      'timestamp': timestamp,
      'type': type
    };
  }

  // factory ChatModel.fromDocument(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   final List<dynamic>? messagesData = data['messages'];
  //   final List<Message> messages = messagesData != null
  //       ? messagesData
  //           .map((messageData) =>
  //               Message(content: messageData, type: data['type']))
  //           .toList()
  //       : [];

  //   return ChatModel(
  //       id: doc.id,
  //       userEmisorId: data['userEmisorId'],
  //       userReceptorId: data['userReceptorId'],
  //       messages: messages,
  //       timestamp: data['timestamp'],
  //       type: data['type']);
  // }

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<dynamic>? messagesData = data['messages'];
    final List<Message> messages = messagesData != null
        ? messagesData
            .map((messageData) => Message(
                  content: messageData != null
                      ? messageData['content'] as String
                      : '', // Corrección aquí
                  type: data['type'] != null
                      ? _mapIntToMessageType(data['type'] as int)
                      : MessageType.unknown,
                ))
            .toList()
        : [];

    return ChatModel(
      id: doc.id,
      userEmisorId: data['userEmisorId'],
      userReceptorId: data['userReceptorId'],
      messages: messages,
      timestamp: data['timestamp'],
      type: data['type'] != null
          ? _mapIntToMessageType(data['type'] as int)
          : MessageType.unknown,
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
}
