import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class GetContactsUseCase {
  final UserRepository userRepository;

  GetContactsUseCase(this.userRepository);

  Future<void> execute(String id) async {
    await userRepository.getContacts(id);
  }
}