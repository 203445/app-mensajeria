// import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
// import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/domain/repositories/chats_repository.dart';

import '../../data/models/chats_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class CreateChatsUsecase {
  final ChatsRepository chatsRepository;

  CreateChatsUsecase(this.chatsRepository);

  Future<List<ChatModel>> execute(userEmisor, userReceptor) async {
    return await chatsRepository.createChats(userEmisor, userReceptor);
  }
}
