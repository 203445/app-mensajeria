// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

import '../../data/models/chats_model.dart';

class GetMessageUseCase {
  final ChatsRepository chatsRepository;

  GetMessageUseCase({required this.chatsRepository});

  Future<List<ChatModel>> execute(String chatId) async {
    return await chatsRepository.getMessage(chatId);
  }
}
