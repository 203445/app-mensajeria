import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository userRepository;

  GetUsersUsecase(this.userRepository);

  Future<List<User>> execute(List<String> phones) async {
    return await userRepository.getContacts(phones);
  }
}