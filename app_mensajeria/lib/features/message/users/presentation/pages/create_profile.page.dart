import 'dart:io';

import 'package:app_mensajeria/features/message/users/presentation/pages/test_page.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/profile_form.dart';
import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage extends StatefulWidget {
  final String email;
  final String password;

  const CreateProfilePage(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController userdataController = TextEditingController();
  File? _profileimage;

  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) {
      return;
    }
    setState(() {
      _profileimage = File(img.path);
    });
  }

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
            } else if (state is LoadedPage) {
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
                                    "Crea tu perfil",
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
                                      top: MediaQuery.of(context).size.height *
                                          0.075,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.1975),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Form(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(children: [
                                            CircleAvatar(
                                                radius: 76,
                                                backgroundImage: _profileimage !=
                                                        null
                                                    ? Image.file(_profileimage!)
                                                        .image
                                                    : Image.asset(
                                                            "assets/images/default-user.png")
                                                        .image),
                                            Positioned(
                                                right: -1,
                                                bottom: -3,
                                                child:
                                                    FloatingActionButton.small(
                                                  onPressed: () {
                                                    getImage();
                                                  },
                                                  backgroundColor:
                                                      Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? DarkModeColors
                                                              .accentColor
                                                          : LightModeColors
                                                              .accentColor,
                                                  child: const Icon(Icons.edit,
                                                      color: Color.fromARGB(
                                                          236, 255, 255, 255)),
                                                ))
                                          ]),
                                          TextFormField(
                                            controller: usernameController,
                                            decoration: InputDecoration(
                                              hintText: "Nombre",
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
                                          TextFormField(
                                            controller: userdataController,
                                            decoration: InputDecoration(
                                              hintText: "Información",
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
                                            context.read<UsersBloc>().add(CreateProfile(
                                              email: widget.email, 
                                              password: widget.password, 
                                              name: usernameController.text, 
                                              data: userdataController.text, 
                                              img: _profileimage != null ? _profileimage: File("assets/images/default-user.png")))
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
            } else if (state is UserCreated) {
              return Center(
                 child: FutureBuilder(
                  future: Future.delayed(Duration.zero, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestPage(user: state.user,)));
                  }),
                  builder: (context, snapshot) {
                    return Container();
                  })
              );
            }else if (state is Error) {
              return Center(
                child: Text(state.error,
                    style: const TextStyle(color: Colors.red)),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
