import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class VerifyUserExistenceUseCase {
  final UserRepository userRepository;
  User? user;
  bool _userExists = false;

  VerifyUserExistenceUseCase(this.userRepository);

  Future<bool> execute(String phone) async {
    user =  await userRepository.getUserbyPhone(phone);
    
    if(user != null) {
      _userExists = true;
    }

    return _userExists;
  }
}