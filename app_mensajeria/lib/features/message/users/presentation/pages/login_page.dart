import 'package:app_mensajeria/features/message/users/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:app_mensajeria/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? DarkModeColors.backgroundColor
            : LightModeColors.backgroundColor,
        body: SafeArea(child: Center(
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
                                ? "assets/img/Logo_darkmode.png"
                                : "assets/img/Logo_lightmode.png",
                            height: MediaQuery.of(context).size.height * 0.24,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                top: MediaQuery.of(context).size.height * 0.045,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.105),
                            child: Form(
                              key: _formKey,
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.150,
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
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                  },
                                ),
                              ),
                            ),
                          ),
                          const MainButton(textButton: "Siguiente")
                        ])),
              ),
            );
          }),
        )));
  }
}
