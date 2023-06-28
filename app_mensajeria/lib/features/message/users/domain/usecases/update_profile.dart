import 'dart:io';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class UpdateProfileUseCase {
  final UserRepository userRepository;

  UpdateProfileUseCase(this.userRepository);

  Future<bool> execute(String id, String name, String data, File? img) async {
    return await userRepository.updateProfile(id, name, data, img);
  }
}
