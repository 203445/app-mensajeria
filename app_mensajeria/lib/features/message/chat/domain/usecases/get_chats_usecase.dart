import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

class GetChatsUsecase {
  final ChatsRepository chatsRepository;

  GetChatsUsecase(this.chatsRepository);

  Future<List<Chats>> execute() async {
    return await chatsRepository.getChats();
  }
}
