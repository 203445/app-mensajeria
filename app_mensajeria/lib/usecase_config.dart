import 'features/message/chat/domain/usecases/create_chats_usecase.dart';
import 'features/message/chat/domain/usecases/delete_chats_usecase.dart';
import 'features/message/chat/domain/usecases/get_chats_usecase.dart';

class UsecaseConfig {
  GetChatsUsecase? getGameUsecase;
  CreateChatsUsecase? createGameUsecase;
  // UpdateGameUsecase? updateGameUsecase;
  DeleteChatsUsecase? deleteGameUsecase;
  // GameRepositoryImpl? gameRepositoryImpl;
  // GamesRemoteDataSourceImp? gamesRemoteDataSourceImp;

  // UsecaseConfig() {
  //   gamesRemoteDataSourceImp = GamesRemoteDataSourceImp();
  //   gameRepositoryImpl =
  //       GameRepositoryImpl(gamesRemoteDataSource: gamesRemoteDataSourceImp!);
  //   getGameUsecase = GetGameUsecase(gameRepositoryImpl!);
  //   createGameUsecase = CreateGameUsecase(gameRepositoryImpl!);
  //   updateGameUsecase = UpdateGameUsecase(gameRepositoryImpl!);
  //   deleteGameUsecase = DeleteGameUsecase(gameRepositoryImpl!);
}
