import 'package:app_mensajeria/features/message/users/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.deepPurple;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: primaryColor.withOpacity(0.4),
          selectionHandleColor: primaryColor,
          cursorColor: primaryColor,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primaryColor,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: primaryColor.withOpacity(0.4),
          selectionHandleColor: primaryColor,
          cursorColor: primaryColor,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
  }
}

