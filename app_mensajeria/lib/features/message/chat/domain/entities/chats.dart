import '../../../users/domain/entities/users.dart';

class Chats {
  final String mensaje;
  User userEmisor;
  User userReceptor;

  Chats({
    required this.mensaje,
    required this.userEmisor,
    required this.userReceptor,
  });
}
