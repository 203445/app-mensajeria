import 'package:app_mensajeria/features/message/users/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mensajeria/styles.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? DarkModeColors.backgroundColor
          : LightModeColors.backgroundColor,
      body: SafeArea(
        child: Center(
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
                            height: MediaQuery.of(context).size.height * 0.085,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                top: MediaQuery.of(context).size.height * 0.075,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.395),
                            child: Form(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(4, (index) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.165,
                                        child: TextFormField(
                                          //onSaved: () => {},
                                          onChanged: (value) {
                                            if (value.length == 1 &&
                                                index < 4) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark
                                                ? DarkModeColors.detailColor
                                                : LightModeColors.detailColor,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 129, 78, 192),
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      );
                                    }))),
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
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? DarkModeColors.accentColor
                                              : LightModeColors.accentColor,
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                          ),
                          const MainButton(textButton: "Siguiente")
                        ])),
              ),
            );
          }),
        ),
      ),
    );
  }
}
