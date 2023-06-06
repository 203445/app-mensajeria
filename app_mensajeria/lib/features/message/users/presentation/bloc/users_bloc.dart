import 'dart:convert' as convert;
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_code_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/data/models/user_model.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/send_message_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final SendMessageUseCase sendMessageUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;

  UsersBloc({required this.sendMessageUseCase, required this.verifyCodeUseCase}) : super(InitialState()){
    on<UsersEvent>(event, emit) async {
      if (event is SendMesssage){
        try {
          emit(Loading());
          bool response = await sendMessageUseCase.execute(event.phone);
          emit(Loaded(response: response));
        } catch (e) {
           emit(Error(error: e.toString()));
        }
      }
    }
  }
}