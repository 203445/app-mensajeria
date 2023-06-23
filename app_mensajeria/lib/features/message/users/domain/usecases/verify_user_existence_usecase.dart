import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class VerifyUserExistenceUseCase {
  final UserRepository userRepository;

  VerifyUserExistenceUseCase(this.userRepository);

  Future<bool> execute(String email) async {
    return await userRepository.verifyExistence(email);
  }
}