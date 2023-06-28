import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class GetUserFirebaseUseCase {
  final UserRepository userRepository;

  GetUserFirebaseUseCase(this.userRepository);

  Future<User?> execute(String idFirebase) async {
    return await userRepository.getFireId(idFirebase);
  }
}
