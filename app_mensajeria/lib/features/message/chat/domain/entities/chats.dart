class Message {
  final MessageType type;
  final String content;

  Message({required this.type, required this.content});
}

enum MessageType {
  text,
  image,
  audio,
  video,
  gif,
  unknown,
}

class Chats {
  final String id;
  final String userEmisorId;
  final String userReceptorId;
  final List<Message> messages;
  final String timestamp;
  final MessageType type;

  Chats(
      {required this.id,
      required this.userEmisorId,
      required this.userReceptorId,
      required this.messages,
      required this.timestamp,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      'timestamp': timestamp,
      'type': type,
    };
  }
}
