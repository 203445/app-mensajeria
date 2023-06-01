import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/users/domain/repositories/chats_repository.dart';

class DeleteChatsUsecase {
  final ChatsRepository chatsRepository;

  DeleteChatsUsecase(this.chatsRepository);

  Future<List<Chats>> execute() async {
    return await chatsRepository.deleteChats();
  }
}
