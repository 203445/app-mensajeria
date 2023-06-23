import 'dart:convert' as convert;
import 'dart:io';
import 'package:app_mensajeria/features/message/users/domain/usecases/add_contact.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/create_profile_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_user_existence_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

import '../../domain/usecases/get_contacts_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/update_profile.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final VerifyUserExistenceUseCase verifyUserExistenceUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final AddContactUseCase addContactUseCase;
  final GetContactsUseCase getContactsUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetUserUseCase getUserUseCase;

  UsersBloc(
      {required this.verifyUserExistenceUseCase,
      required this.createProfileUseCase,
      required this.addContactUseCase,
      required this.getContactsUseCase,
      required this.updateProfileUseCase,
      required this.getUserUseCase})
      : super(LoadedPage()) {
    on<UsersEvent>((event, emit) async {
      if (event is Register) {
        try {
          emit(Loading());
          bool response = await verifyUserExistenceUseCase.execute(event.email);
          if (response == false) {
            emit(VerifiedUser(response: response));
          } else {
            emit(Error(error: 'Este correo ya este en uso.'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(LoadedPage());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 

      else if (event is SignedInHome){
        try {
          emit(Loading());
          final User? user = await getUserUseCase.execute(event.id);
          if (user != null) {
            emit(LoadedUser(user: user));
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
      
      else if (event is HomeNavegation) {
        try {
          emit(Loading());
          if (event.index == 1) {
            final List<User> contacts =
                await getContactsUseCase.execute(event.id);
            emit(LoadedContacts(contacts: contacts));
          } else {
            emit(LoadedPage()); //Emit LoadedChats
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 
      
      else if (event is PageNavegation) {
        try {
          await Future.delayed(const Duration(milliseconds: 60), () {
            emit(LoadedPage());
          });
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 
      
      else if (event is CreateProfile) {
        try {
          emit(Loading());
          User? user = await createProfileUseCase.execute(
              event.name, event.data, event.img, event.email, event.password);
          if (user != null) {
            emit(UserCreated(user: user));
          } else {
            emit(Error(error: 'Ocurrio un error creando tu cuenta.'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(LoadedPage());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 

      else if (event is EditProfile){
        try {
          emit(Loading());
          bool res = await updateProfileUseCase.execute(event.id, event.name, event.data, event.img);
          if (res == true) {
            print("EDITADO");
            User? user = await getUserUseCase.execute(event.id);
            if (user != null) {
            emit(UserEdited(user: user));
          }
          } else {
            emit(Error(error: 'Ocurrio un error editando tu cuenta.'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(LoadedPage());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
          await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(LoadedPage());
            });
        }
      }
      
      else if (event is AddContact) {
        try {
          emit(Loading());
          bool response = await verifyUserExistenceUseCase.execute(event.email);
          if (response) {
            bool success =
                await addContactUseCase.execute(event.email, event.id);
            emit(LoadedPage());
          } else {
            emit(Error(error: 'El usuario que deseas agregar no existe'));
            await Future.delayed(const Duration(milliseconds: 2500), () {
              emit(LoadedPage());
            });
          }
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 
      
      else if (event is ReturnPage) {
        emit(LoadedPage());
      }
    });
  }
}
