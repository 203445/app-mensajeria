import 'package:app_mensajeria/features/message/users/data/datasources/user_remote.dart';
import 'package:app_mensajeria/features/message/users/data/repositories/user_repository_imp.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/create_profile_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/send_message_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_code_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_user_existence_usecase.dart';

import 'features/message/chat/domain/usecases/create_chats_usecase.dart';
import 'features/message/chat/domain/usecases/delete_chats_usecase.dart';
import 'features/message/chat/domain/usecases/get_chats_usecase.dart';

class UsecaseConfig {
  SendMessageUseCase? sendMessageUseCase;
  VerifyCodeUseCase? verifyCodeUseCase;
  VerifyUserExistenceUseCase? verifyUserExistenceUseCase;
  CreateProfileUseCase? createProfileUseCase;
  UserRemoteDataSourceImp? userRemoteDataSourceImp;
  UserRepositoryImp? userRepositoryImp;

  //GetChatsUsecase? getGameUsecase;
  //CreateChatsUsecase? createGameUsecase;
  //DeleteChatsUsecase? deleteGameUsecase;
  

  UsecaseConfig() {
    userRemoteDataSourceImp = UserRemoteDataSourceImp();
    userRepositoryImp = UserRepositoryImp(userRemoteDataSource: userRemoteDataSourceImp!);
    sendMessageUseCase = SendMessageUseCase(userRepositoryImp!);
    verifyCodeUseCase = VerifyCodeUseCase(userRepositoryImp!);
    verifyUserExistenceUseCase = VerifyUserExistenceUseCase(userRepositoryImp!);
    createProfileUseCase = CreateProfileUseCase(userRepositoryImp!);
  }
}
