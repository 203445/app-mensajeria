import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class SignInUseCase {
  final UserRepository userRepository;
  late User? existentUser;

  SignInUseCase(this.userRepository);

  Future<void> execute(User user) async {
    existentUser = await userRepository.getUserbyPhone(user.telefono);

    if (existentUser == null) {
      await userRepository.createUser(user);
    }
  }
}