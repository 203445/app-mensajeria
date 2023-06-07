// import '../../../users/domain/entities/users.dart';

class Chats {

  final String id;
  final String userEmisorId;
  final String userReceptorId;
  final List<Map<String, dynamic>> messages;
  final String timestamp;

  Chats({

    required this.id,
    required this.userEmisorId,
    required this.userReceptorId,
    required this.messages,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmisorId': userEmisorId,
      'userReceptorId': userReceptorId,
      'messages': messages,
      'timestamp': timestamp,
    };
  }
}
