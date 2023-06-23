// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class SendMessageUseCase {
  final ChatsRepository chatsRepository;

  SendMessageUseCase({required this.chatsRepository});

  Future<void> execute(String chatId, String message, int type, String userId) async {
    await chatsRepository.sendMessage(chatId, message, type, userId);
  }
}
