import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUsecase getChatsUsecase;

  ChatBloc({required this.getChatsUsecase}) : super(ChatLoading()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetChatsEvent) {
        emit(ChatLoading());
        try {
          final List<Chats> chats = await getChatsUsecase.execute('jsjsj');
          print(chats);
          emit(ChatLoaded(chats: chats));
        } catch (error) {
          emit(ChatError('Error al cargar los chats'));
        }
      }
    });
  }
}
