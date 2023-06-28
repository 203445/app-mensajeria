import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/create_profile.page.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? DarkModeColors.backgroundColor
            : LightModeColors.backgroundColor,
        body: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 2500), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }),
            builder: (context, snapshot) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? "assets/images/Logo_darkmode.png"
                            : "assets/images/Logo_lightmode.png",
                        height: MediaQuery.of(context).size.height * 0.175,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.accentColor
                              : LightModeColors.accentColor,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
