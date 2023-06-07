import 'package:app_mensajeria/features/message/users/presentation/pages/create_profile.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String verificationId;
  const PhoneVerificationPage({super.key, required this.verificationId});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController pinController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
        } else if (state is InitialState) {
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
                            SizedBox(
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.085,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Verificar código",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.textColorTitles
                                            : LightModeColors.textColorTitles),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "Código enviado a +529611234567",
                                    style: TextStyle(
                                        fontSize: 16,
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
                                      0.075,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.395),
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.125,
                                child: Pinput(
                                  androidSmsAutofillMethod:
                                      AndroidSmsAutofillMethod.none,
                                  controller: pinController,
                                  length: 6,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  validator: (value) {
                                    return value?.length == 6
                                        ? null
                                        : 'Por favor, completa los datos';
                                  },
                                  defaultPinTheme: PinTheme(
                                      height: 70,
                                      width: 55,
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.textColor
                                              : LightModeColors.textColor),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Color.fromARGB(
                                                        255, 24, 24, 24)
                                                    : const Color.fromARGB(
                                                        255, 168, 168, 168),
                                            spreadRadius: 0.5,
                                            blurRadius: 1,
                                            offset: const Offset(0, 0.75),
                                          )
                                        ],
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.detailColor
                                            : LightModeColors.detailColor,
                                      )),
                                  focusedPinTheme: PinTheme(
                                      height: 70,
                                      width: 55,
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.textColor
                                              : LightModeColors.textColor),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Color.fromARGB(
                                                      255, 24, 24, 24)
                                                  : const Color.fromARGB(
                                                      255, 168, 168, 168),
                                              spreadRadius: 0.5,
                                              blurRadius: 1,
                                              offset: const Offset(0, 0.5),
                                            )
                                          ],
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.detailColor
                                              : LightModeColors.detailColor,
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  165, 105, 239, 1),
                                              width: 2.0))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "¿Algún problema? ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.textColor
                                            : LightModeColors.textColor),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text("Reenviar código",
                                        style: TextStyle(
                                            fontSize: 15.5,
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? DarkModeColors.accentColor
                                                : LightModeColors.accentColor,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (pinController.text != null) {
                                      context.read<UsersBloc>().add(
                                          SendVerification(id: widget.verificationId, code: pinController.text));
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
                            ),
                          ])),
                ),
              );
            }),
          );
        } else if (state is VerifiedPhone) {
          return FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 350), () {
              print(state.response);
            }),
            builder: (context, snapshot) {
              return Center(
                child:Text(state.response.toString())
              );
            },
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
