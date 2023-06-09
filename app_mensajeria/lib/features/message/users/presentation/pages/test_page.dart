import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/create_profile.page.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatefulWidget {
  final User user;
  const TestPage({Key? key, required this.user}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  void initState() {
    context.read<UsersBloc>().add(PageNavegation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? DarkModeColors.backgroundColor
          : LightModeColors.backgroundColor,
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is Loading){
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkModeColors.accentColor
                  : LightModeColors.accentColor,
            ),
          );
        } else if (state is LoadedPage) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Se ha creado el usuario"),
                    ElevatedButton(onPressed: () { 
                      print("ID: ${widget.user.id}  Nombre: ${widget.user.name}  Informacion: ${widget.user.data}  Firebase: ${widget.user.firebaseId}"); 
                      }, child: Text("Ver mis datos")
                    ),
                    ElevatedButton(onPressed: () { 
                      context.read<UsersBloc>().add(AddContact(email: "testcontact4@mail.com", id: widget.user.id));
                      }, child: Text("Test agregar contacto")
                    ),
                    ElevatedButton(onPressed: () { 
                      context.read<UsersBloc>().add(GetContacts(id: widget.user.id));
                      }, child: Text("Test ver contactos")
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is Error) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.175,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ups, ha ocurrido un error",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? DarkModeColors.textColorTitles
                                  : LightModeColors.textColorTitles),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "${state.error} Regresando a la página anterior...",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? DarkModeColors.textColor
                                  : LightModeColors.textColor),
                                  textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:70),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? DarkModeColors.accentColor
                          : LightModeColors.accentColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is LoadedFeed) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 650,
                      child: ListView.separated(
                      itemCount: state.contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.blueGrey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(state.contacts[index].id),
                            Text(state.contacts[index].name),
                            Text(state.contacts[index].data),
                            Text(state.contacts[index].firebaseId),
                            Text(state.contacts[index].img)
                            
                          ]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                    ),
                    ),
                    ElevatedButton(onPressed: () {
                      context.read<UsersBloc>().add(ReturnPage());
                    }, child: Text("Regresar"))
                  ],
                ),
              ),
            ),
          );

        }else {
          return Container();
        }
      }),
    );
  }
}