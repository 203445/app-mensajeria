import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chats {
  ChatModel({
    required String id,
    required String userEmisorId,
    required String userReceptorId,
   
    required Map<String, dynamic> messages,
  }) : super(
          id: id,
          userEmisorId: userEmisorId,
          userReceptorId: userReceptorId,
          messages: messages,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"],
      userEmisorId: json['userEmisorId'],
      userReceptorId: json['userReceptorId'],
      
      messages: json['messages'],
    );
  }

  factory ChatModel.fromEntity(Chats chats) {
    return ChatModel(
      id: chats.id,
      userEmisorId:
          chats.userEmisorId, // Establece el ID del emisor correctamente
      userReceptorId:
          chats.userReceptorId, // Establece el ID del receptor correctamente
      messages: chats.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
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
      id: data['id'],
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
}
