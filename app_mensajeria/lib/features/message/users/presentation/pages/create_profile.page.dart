import 'package:app_mensajeria/features/message/users/presentation/widgets/main_button.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
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
                                top: MediaQuery.of(context).size.height * 0.075,
                                bottom: MediaQuery.of(context).size.height *
                                    0.1975),
                            child: const ProfileForm(),
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
