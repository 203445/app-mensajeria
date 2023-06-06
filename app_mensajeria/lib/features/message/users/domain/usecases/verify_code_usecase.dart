import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class VerifyCodeUseCase {
  final UserRepository userRepository;

  VerifyCodeUseCase(this.userRepository);

  Future<bool> execute(String id, String code) async {
    return await userRepository.verifyCode(id, code);
  }
}