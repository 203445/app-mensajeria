enum MessageType {
  text,
  image,
  audio,
  video,
  gif,
  unknown,
}

class Chats {
  // final String userId;
  final String userEmisorId;
  final String userReceptorId;
  final Map<String, dynamic> messages;
  // final String timestamp;
  // final MessageType type;

  Chats(
      {
      //required this.userId,
      required this.userEmisorId,
      required this.userReceptorId,
      required this.messages,
      // required this.timestamp,
      // required this.type
      });

  Map<String, dynamic> toMap() {
    return {
      // 'userId': userId,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      // 'timestamp': timestamp,
      // 'type': type,
    };
  }
}
