import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../styles.dart';
import '../bloc/users_bloc.dart';
import '../widgets/error_view.dart';

class AddContactPage extends StatefulWidget {
  final String id;
  const AddContactPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? DarkModeColors.backgroundColor
            : LightModeColors.backgroundColor,
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.accentColor
                      : LightModeColors.accentColor,
                ),
              );
            } else if (state is LoadedContacts) {
              return Center(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstrains) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstrains.maxHeight),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 40),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Agregar contacto",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.textColorTitles
                                            : LightModeColors.textColorTitles),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *0.075,
                                      bottom:MediaQuery.of(context).size.height *0.1975),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *0.4,
                                    child: Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              hintText: "Correo electronico",
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? DarkModeColors.detailColor
                                                  : LightModeColors.detailColor,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                         
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: OutlinedButton(
                                      onPressed: () => {
                                            context.read<UsersBloc>().add(AddContact(id: widget.id, email: emailController.text))
                                          },
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          backgroundColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? DarkModeColors.accentColor
                                                  : LightModeColors.accentColor,
                                          side: BorderSide(
                                              width: 1.5,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? DarkModeColors.accentColor
                                                  : LightModeColors
                                                      .accentColor),
                                          elevation: 5),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: Text(
                                          "Siguiente",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xFFF1F1F1)),
                                        ),
                                      )),
                                ),
                              ])),
                    ),
                  );
                }),
              );
            } else if (state is LoadedPage) {
              return Center(
                 child: FutureBuilder(
                  future: Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  }),
                  builder: (context, snapshot) {
                    return Container();
                  })
              );
            }else if (state is Error) {
              return const ErrorView();
            } else {
              return Container();
            }
          },
        ));
  }
}