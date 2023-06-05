import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class LogoutUsecase {
  final UserRepository userRepository;

  LogoutUsecase(this.userRepository);

  Future<void> execute(User user) async {
    await userRepository.getUserbyPhone(user.telefono);
  }
}