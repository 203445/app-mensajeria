import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class CreateProfileUseCase {
  final UserRepository userRepository;

  CreateProfileUseCase(this.userRepository);

  Future<User> execute(User user) async {
    return await userRepository.createProfile(user);
  }
}