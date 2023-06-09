import 'dart:io';

import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/user_repository.dart';

class CreateProfileUseCase {
  final UserRepository userRepository;

  CreateProfileUseCase(this.userRepository);

  Future<User?> execute(String name, String data, File? img, String email, String password) async {
    return await userRepository.createProfile(name, data, img!, email, password);
  }
}