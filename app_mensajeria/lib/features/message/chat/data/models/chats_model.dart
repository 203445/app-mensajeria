import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chats {
  ChatModel({
    required String id,
    required String userEmisorId,
    required String userReceptorId,
    required List<Message> messages,
    required String timestamp,
    required int type,
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

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
        id: doc.id,
        userEmisorId: data['userEmisorId'],
        userReceptorId: data['userReceptorId'],
        messages: List<Message>.from(data['messages']),
        timestamp: data['timestamp'],
        type: data['type']);
  }
}

// class TypeMessage {
//   static const text = 0;
//   static const image = 1;
//   static const video = 2;
//   static const audio = 3;
//   static const gif = 4;
// }
