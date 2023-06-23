import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class AddContactUseCase {
  final UserRepository userRepository;

  AddContactUseCase(this.userRepository);

  Future<bool> execute(String email, String id) async {
    return await userRepository.addContact(email, id);
  }
}