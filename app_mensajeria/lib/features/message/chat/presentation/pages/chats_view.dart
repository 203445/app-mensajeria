// import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/presentation/pages/chat_individual.dart';
import 'package:app_mensajeria/usecase_config.dart';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:file_picker/file_picker.dart';

// import '../../../../../main.dart';
// import '../bloc/chats_bloc.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  final UsecaseConfig usecaseConfig = UsecaseConfig();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todos los chats'),
//       ),
//       body: BlocBuilder<ChatBloc, ChatState>(
//         builder: (context, state) {
//           if (state is ChatLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ChatError) {
//             return Center(child: Text(state.errorMessage));
//           } else if (state is ChatLoaded) {
//             final chats = state.chats;
//             return ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];
//                 final messageContent = chat.messages['content'];
//                 final messageTimestamp = chat.messages['timestamp'];
//                 return ListTile(
//                   title: Text('Chat ID: ${chat.userEmisorId}'),
//                   subtitle: Text(
//                     'Mensaje: $messageContent, Enviado: $messageTimestamp, Receptor: ${chat.userReceptorId}',
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatDetailPage(
//                           chatId: chat.userReceptorId,
//                           usecaseConfig: usecaseConfig,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los chats'),
      ),
      // body: const Text('Holaa'),
      body: FutureBuilder<List<Chats>>(
        future: usecaseConfig.getChatsUsecase!.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los chats'));
          } else {
            final chats = snapshot.data ?? [];
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final messageContent = chat.messages['content'];
                final messageTimestamp = chat.messages['timestamp'];
                return ListTile(
                  title: Text('Chat ID: ${chat.userEmisorId}'),
                  subtitle: Text(
                    'Mensaje: $messageContent, Enviado: $messageTimestamp, Receptor: ${chat.userReceptorId}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(
                          chatId: 'AvdViv2isUzZ178FM6Cc',
                          usecaseConfig: usecaseConfig,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
