import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/phone_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance; //eliminar
  late String? phoneValue = "";

  //Cambiar a sendmessage
  Future<void> logIn(String? phone) async {
    auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          print(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhoneVerificationPage(
                        verificationId: verificationId,
                      )));
        },
        codeAutoRetrievalTimeout: (e) {
          print(e.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? DarkModeColors.backgroundColor
            : LightModeColors.backgroundColor,
        body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
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
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ingresar",
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
                                    "Te enviaremos un código de verificación",
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
                                      0.105),
                              child: Form(
                                key: _formKey,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height *
                                      0.150,
                                  child: IntlPhoneField(
                                    decoration: InputDecoration(
                                      hintText: "Telefono",
                                      filled: true,
                                      fillColor: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? DarkModeColors.detailColor
                                          : LightModeColors.detailColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    initialCountryCode: 'MX',
                                    onChanged: (value) {
                                      setState(() {
                                        phoneValue = value.completeNumber;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: OutlinedButton(
                                  onPressed: () async {
                                    logIn(phoneValue);
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
        }));
  }
}
