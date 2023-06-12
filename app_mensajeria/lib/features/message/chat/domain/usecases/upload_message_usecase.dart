import 'dart:io';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class UploadMediaUseCase {
  final ChatsRepository chatsRepository;

  UploadMediaUseCase({required this.chatsRepository});

  Future<String> execute(String path, File file) async {
    return await chatsRepository.uploadMedia(path, file);
  }
}
