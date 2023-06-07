import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatModel extends Chats {
  ChatModel({
    //   required String mensaje,
    // required User userEmisor,
    // required User userReceptor
    required String id,
    required String userEmisorId,
    required String userReceptorId,
    required List<Map<String, dynamic>> messages,
    required String timestamp,
  }) : super(
          // mensaje: mensaje,
          // userEmisor: userEmisor,
          // userReceptor: userReceptor
          id: id,
          userEmisorId: userEmisorId,
          userReceptorId: userReceptorId,
          messages: messages,
          timestamp: timestamp
        );

  // factory ChatModel.fromJson(Map<String, dynamic> json) {
  //   return ChatModel(
  //     mensaje: json['mensaje'],
  //     userEmisor: json['emisor'],
  //     userReceptor: json['receptor'],
  //   );
  // }
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      userEmisorId: json['userEmisorId'],
      userReceptorId: json['userReceptorId'],
      messages: List<Map<String, dynamic>>.from(json['messages']),
      timestamp: json['timestamp']
    );
  }

  // factory ChatModel.fromEntity(Chats chats) {
  //   return ChatModel(
  //     mensaje: chats.mensaje,
  //     userEmisor: chats.userEmisor,
  //     userReceptor: chats.userReceptor,
  //   );
  // }

  factory ChatModel.fromEntity(Chats chats) {
    return ChatModel(
      id: '', // Establece el valor correcto del ID del chat
      userEmisorId:
          chats.userEmisorId, // Establece el ID del emisor correctamente
      userReceptorId:
          chats.userReceptorId, // Establece el ID del receptor correctamente
      messages: [], // Puedes establecer mensajes vacíos o manejarlos de otra manera
      timestamp: chats.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      id: doc.id,
      userEmisorId: data['userEmisorId'],
      userReceptorId: data['userReceptorId'],
      messages: List<Map<String, dynamic>>.from(data['messages']),
      timestamp: data['timestamp'],
    );
  }
}


  // Map<String, dynamic> toJson() {
  //   return {
  //     'mensaje': mensaje,
  //     'emisor': userEmisor,
  //     'receptor': userReceptor,
  //   };
  // }
// }
