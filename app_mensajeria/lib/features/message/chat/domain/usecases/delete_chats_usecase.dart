import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class DeleteChatsUsecase {
  final ChatsRepository chatsRepository;

  DeleteChatsUsecase(this.chatsRepository);

  Future<void> execute(String id) async {
    return await chatsRepository.deleteChats(id);
  }
}
