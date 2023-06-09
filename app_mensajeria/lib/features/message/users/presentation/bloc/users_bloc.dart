import 'dart:convert' as convert;
import 'dart:io';
import 'package:app_mensajeria/features/message/users/domain/usecases/add_contact.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/create_profile_usecase.dart';
import 'package:app_mensajeria/features/message/users/domain/usecases/verify_user_existence_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/data/models/user_model.dart';

import '../../domain/usecases/get_contacts_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final VerifyUserExistenceUseCase verifyUserExistenceUseCase;
  final CreateProfileUseCase createProfileUseCase;
  final AddContactUseCase addContactUseCase;
  final GetContactsUseCase getContactsUseCase;

  UsersBloc(
      {required this.verifyUserExistenceUseCase,
      required this.createProfileUseCase, required this.addContactUseCase, required this.getContactsUseCase})
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
      
      else if (event is PageNavegation) {
        try {
          await Future.delayed(const Duration(milliseconds: 60), () {
              emit(LoadedPage());
            });
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } 
      
      else if (event is CreateProfile){
        try {
          emit(Loading());
          User? user = await createProfileUseCase.execute(event.name, event.data, event.img, event.email, event.password);
          print(user);
          if (user != null) {
            
            print("Holaaaa");
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

      else if (event is AddContact){
        try {
          emit(Loading());
          bool response = await verifyUserExistenceUseCase.execute(event.email);
          if (response) { 
            bool success = await addContactUseCase.execute(event.email, event.id);
            print("Se agrego el contacto");
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

      else if (event is GetContacts){
        try {
          emit(Loading());
          final List<User> contacts = await getContactsUseCase.execute(event.id);
          for (User contact in contacts) {
            print("ID: ${contact.id}  Nombre: ${contact.name}  Informacion: ${contact.data}  Firebase: ${contact.firebaseId}"); 
          }
          emit(LoadedFeed(contacts: contacts));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }

      else if (event is ReturnPage){
        emit(LoadedPage());
      }
    });
  }
}
