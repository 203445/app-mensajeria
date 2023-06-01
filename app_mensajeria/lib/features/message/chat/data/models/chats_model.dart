import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

import '../../../users/domain/entities/users.dart';

class ChatModel extends Chats {
  ChatModel(
      {required String mensaje,
      required User userEmisor,
      required User userReceptor})
      : super(
            mensaje: mensaje,
            userEmisor: userEmisor,
            userReceptor: userReceptor);

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      mensaje: json['mensaje'],
      userEmisor: json['emisor'],
      userReceptor: json['receptor'],
    );
  }

  factory ChatModel.fromEntity(Chats chats) {
    return ChatModel(
      mensaje: chats.mensaje,
      userEmisor: chats.userEmisor,
      userReceptor: chats.userReceptor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
      'emisor': userEmisor,
      'receptor': userReceptor,
    };
  }
}
