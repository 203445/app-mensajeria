import 'package:app_mensajeria/features/message/users/data/datasources/user_remote.dart';
import 'package:app_mensajeria/features/message/users/data/repositories/user_repository_imp.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/add_contact.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/create_profile_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/get_contacts_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/get_user_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/update_profile.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_user_existence_usecase.dart';

import 'features/message/chat/domain/usecases/create_chats_usecase.dart';
import 'features/message/chat/domain/usecases/delete_chats_usecase.dart';
import 'features/message/chat/domain/usecases/get_chats_usecase.dart';

class UsecaseConfig {
  VerifyUserExistenceUseCase? verifyUserExistenceUseCase;
  CreateProfileUseCase? createProfileUseCase;
  AddContactUseCase? addContactUseCase;
  GetContactsUseCase? getContactsUseCase;
  UpdateProfileUseCase? updateProfileUseCase;
  GetUserUseCase? getUserUseCase;

  UserRemoteDataSourceImp? userRemoteDataSourceImp;
  UserRepositoryImp? userRepositoryImp;

  //GetChatsUsecase? getGameUsecase;
  //CreateChatsUsecase? createGameUsecase;
  //DeleteChatsUsecase? deleteGameUsecase;
  

  UsecaseConfig() {
    userRemoteDataSourceImp = UserRemoteDataSourceImp();
    userRepositoryImp = UserRepositoryImp(userRemoteDataSource: userRemoteDataSourceImp!);
    verifyUserExistenceUseCase = VerifyUserExistenceUseCase(userRepositoryImp!);
    createProfileUseCase = CreateProfileUseCase(userRepositoryImp!);
    addContactUseCase = AddContactUseCase(userRepositoryImp!);
    getContactsUseCase = GetContactsUseCase(userRepositoryImp!);
    updateProfileUseCase = UpdateProfileUseCase(userRepositoryImp!);
    getUserUseCase = GetUserUseCase(userRepositoryImp!);
  }
}
