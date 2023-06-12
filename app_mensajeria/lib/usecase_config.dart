import 'package:app_mensajeria/features/message/chat/data/repositories/chat_repository_impl.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/get_menssage_usecase.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/send_menssage_usecase.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/upload_message_usecase.dart';

import 'features/message/chat/data/datasources/chat_remote_data_source.dart';
import 'features/message/chat/domain/usecases/create_chats_usecase.dart';
import 'features/message/chat/domain/usecases/get_chats_usecase.dart';

class UsecaseConfig {
  GetChatsUsecase? getChatsUsecase;
  CreateChatsUsecase? createChatsUsecase;
  SendMessageUseCase? sendMessageUsecase;
  GetMessageUseCase? getMessageUseCase;
  UploadMediaUseCase? uploadMediaUseCase;
  // DeleteChatsUsecase? deleteGameUsecase;
  ChatRepositoryImpl? chatRepositoryImpl;
  ChatRemoteDataSourceImp? chatRemoteDataSourceImp;

  UsecaseConfig() {
    chatRemoteDataSourceImp = ChatRemoteDataSourceImp();
    chatRepositoryImpl =
        ChatRepositoryImpl(chatRemoteDataSource: chatRemoteDataSourceImp!);
    getChatsUsecase = GetChatsUsecase(chatRepositoryImpl!);
    createChatsUsecase = CreateChatsUsecase(chatRepositoryImpl!);
    sendMessageUsecase =
        SendMessageUseCase(chatsRepository: chatRepositoryImpl!);
    getMessageUseCase = GetMessageUseCase(chatsRepository: chatRepositoryImpl!);
    uploadMediaUseCase =
        UploadMediaUseCase(chatsRepository: chatRepositoryImpl!);
  }
}
