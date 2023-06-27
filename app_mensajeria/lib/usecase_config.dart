import 'package:app_mensajeria/features/message/chat/data/repositories/chat_repository_impl.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/get_menssage_usecase.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/send_menssage_usecase.dart';
import 'package:app_mensajeria/features/message/chat/domain/usecases/upload_message_usecase.dart';

import 'features/message/chat/data/datasources/chat_remote_data_source.dart';
import 'features/message/chat/domain/usecases/create_chats_usecase.dart';
import 'features/message/chat/domain/usecases/get_chatId_usecase.dart';
import 'features/message/chat/domain/usecases/get_chats_usecase.dart';
import 'features/message/users/data/datasources/user_remote.dart';
import 'features/message/users/data/repositories/user_repository_imp.dart';
import 'features/message/users/domain/usecases/add_contact.dart';
import 'features/message/users/domain/usecases/create_profile_usecase.dart';
import 'features/message/users/domain/usecases/get_contacts_usecase.dart';
import 'features/message/users/domain/usecases/get_userFirebase.dart';
import 'features/message/users/domain/usecases/get_user_usecase.dart';
import 'features/message/users/domain/usecases/update_profile.dart';
import 'features/message/users/domain/usecases/verify_user_existence_usecase.dart';

class UsecaseConfig {
  GetChatsUsecase? getChatsUsecase;
  CreateChatsUsecase? createChatsUsecase;
  SendMessageUseCase? sendMessageUsecase;
  GetMessageUseCase? getMessageUseCase;
  UploadMediaUseCase? uploadMediaUseCase;
  GetChatIdUsecase? getChatIdUsecase;

  ChatRepositoryImpl? chatRepositoryImpl;
  ChatRemoteDataSourceImp? chatRemoteDataSourceImp;

  VerifyUserExistenceUseCase? verifyUserExistenceUseCase;
  CreateProfileUseCase? createProfileUseCase;
  AddContactUseCase? addContactUseCase;
  GetContactsUseCase? getContactsUseCase;
  UpdateProfileUseCase? updateProfileUseCase;
  GetUserUseCase? getUserUseCase;
  GetUserFirebaseUseCase? getUserFirebaseUsecase;

  UserRemoteDataSourceImp? userRemoteDataSourceImp;
  UserRepositoryImp? userRepositoryImp;

  UsecaseConfig() {
    chatRemoteDataSourceImp = ChatRemoteDataSourceImp();
    chatRepositoryImpl =
        ChatRepositoryImpl(chatRemoteDataSource: chatRemoteDataSourceImp!);
    getChatsUsecase = GetChatsUsecase(chatRepositoryImpl!);
    getChatIdUsecase = GetChatIdUsecase(chatRepositoryImpl!);
    createChatsUsecase = CreateChatsUsecase(chatRepositoryImpl!);
    sendMessageUsecase =
        SendMessageUseCase(chatsRepository: chatRepositoryImpl!);
    getMessageUseCase = GetMessageUseCase(chatsRepository: chatRepositoryImpl!);
    uploadMediaUseCase =
        UploadMediaUseCase(chatsRepository: chatRepositoryImpl!);
    userRemoteDataSourceImp = UserRemoteDataSourceImp();
    userRepositoryImp =
        UserRepositoryImp(userRemoteDataSource: userRemoteDataSourceImp!);
    verifyUserExistenceUseCase = VerifyUserExistenceUseCase(userRepositoryImp!);
    createProfileUseCase = CreateProfileUseCase(userRepositoryImp!);
    addContactUseCase = AddContactUseCase(userRepositoryImp!);
    getContactsUseCase = GetContactsUseCase(userRepositoryImp!);
    updateProfileUseCase = UpdateProfileUseCase(userRepositoryImp!);
    getUserUseCase = GetUserUseCase(userRepositoryImp!);
    getUserFirebaseUsecase = GetUserFirebaseUseCase(userRepositoryImp!);
  }
}
