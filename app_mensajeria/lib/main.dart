import 'package:app_mensajeria/features/message/chat/presentation/chats_view.dart';
import 'package:app_mensajeria/usecase_config.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'features/message/chat/data/repositories/chat_repository_impl.dart';
import 'firebase_options.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //  final uwu =  FirebaseFirestore.instance.collection('chats');
    //   final chatsRepository = ChatRepositoryImpl(chatRemoteDataSource: uwu!);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllChatsPage(),
    );
  }
}
