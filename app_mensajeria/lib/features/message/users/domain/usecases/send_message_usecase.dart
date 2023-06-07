import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class SendMessageUseCase {
  final UserRepository userRepository;

  SendMessageUseCase(this.userRepository);

  String? execute(String phone) {
    return userRepository.sendMessage(phone);
  }
}