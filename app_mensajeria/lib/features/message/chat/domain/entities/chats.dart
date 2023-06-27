enum MessageType {
  text,
  image,
  audio,
  video,
  gif,
  unknown,
}

// Asignar valores enteros a los tipos de mensaje
extension MessageTypeExtension on MessageType {
  int get intValue {
    switch (this) {
      case MessageType.text:
        return 0;
      case MessageType.image:
        return 1;
      case MessageType.audio:
        return 2;
      case MessageType.video:
        return 3;
      case MessageType.gif:
        return 4;
      default:
        return -1;
    }
  }
}

class Chats {
  final String id;
  final String userEmisorId;
  final String userReceptorId;
  final Map<String, dynamic> messages;

  Chats({
    required this.id,
    required this.userEmisorId,
    required this.userReceptorId,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id:': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
    };
  }
}
