import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class CreateChatsUsecase {
  final ChatsRepository chatsRepository;

  CreateChatsUsecase(this.chatsRepository);

  Future<void> execute(Chats chats) async {
    return await chatsRepository.createChats(chats);
  }
}
