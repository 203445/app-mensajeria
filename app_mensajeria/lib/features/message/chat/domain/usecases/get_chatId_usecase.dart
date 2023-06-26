import '../repositories/chats_repository.dart';

class GetChatIdUsecase {
  final ChatsRepository chatsRepository;

  GetChatIdUsecase(this.chatsRepository);

  Future<String?> execute(userEmisor, userReceptor) async {
    return await chatsRepository.getChatId(userEmisor, userReceptor);
  }
}
