// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class GetMessageUseCase {
  final ChatsRepository chatsRepository;

  GetMessageUseCase({required this.chatsRepository});

  Future<List<Map<String, dynamic>>> execute(String chatId) async {
    return await chatsRepository.getMessage(chatId);
  }
}
