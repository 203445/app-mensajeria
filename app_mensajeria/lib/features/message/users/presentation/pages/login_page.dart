import 'dart:core';

import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/create_profile.page.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? DarkModeColors.backgroundColor
          : LightModeColors.backgroundColor,
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
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
                  constraints:
                      BoxConstraints(minHeight: viewportConstrains.maxHeight),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 40),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? "assets/images/Logo_darkmode.png"
                                  : "assets/images/Logo_lightmode.png",
                              height: MediaQuery.of(context).size.height * 0.24,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Registrarse",
                                    style: TextStyle(
                                        fontSize: 42,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.textColorTitles
                                            : LightModeColors.textColorTitles),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "Por favor, ingresa tus datos",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.textColor
                                            : LightModeColors.textColor),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.045,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.125),
                              child: Form(
                                key: _formKey,
                                child: SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.185,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.email),
                                            hintText: "Correo eléctronico",
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
                                          style: const TextStyle(fontSize: 18),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Por favor, ingresa un correo electrónico';
                                            } else if (!RegExp(emailRegex)
                                                .hasMatch(value)) {
                                              return 'Ingresa un correo electrónico válido';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock),
                                            hintText: "Contraseña",
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
                                          style: const TextStyle(fontSize: 18),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Por favor, ingresa una contraseña';
                                            } else if (!RegExp(passwordRegex)
                                                .hasMatch(value)) {
                                              return 'La contraseña debe tener al menos 8 caracteres, una letra y un número';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<UsersBloc>().add(Register(
                                          email: emailController.text,
                                          password: passwordController.text));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.accentColor
                                              : LightModeColors.accentColor,
                                      side: BorderSide(
                                          width: 1.5,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.accentColor
                                              : LightModeColors.accentColor),
                                      elevation: 5),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      "Siguiente",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFFF1F1F1)),
                                    ),
                                  )),
                            )
                          ])),
                ),
              );
            }),
          );
        } else if (state is VerifiedUser) {
          return Center(
              child: FutureBuilder(
                  future: Future.delayed(Duration.zero, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateProfilePage(
                                email: emailController.text,
                                password: passwordController.text)));
                  }),
                  builder: (context, snapshot) {
                    return Container();
                  }));
        } else if (state is Error) {
          return const ErrorView();
        } else {
          return Container();
        }
      }),
    );
  }
}
