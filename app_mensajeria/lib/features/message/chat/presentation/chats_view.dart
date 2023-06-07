import 'package:app_mensajeria/usecase_config.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';

class AllChatsPage extends StatelessWidget {
  final UsecaseConfig usecaseConfig = UsecaseConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos los chats'),
      ),
      body: Text('Holaa'),
//       body: FutureBuilder<List<Chats>>(
//         future: usecaseConfig.getChatsUsecase!.execute(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error al cargar los chats'));
//           } else {
//             final chats = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 final chat = chats[index];
//                 return ListTile(
//                   title: Text('Chat ID: ${chat.id}'),
//                   subtitle: Text('Emisor: ${chat.userEmisorId}, Receptor: ${chat.userReceptorId}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatDetailPage(
//                           chatId: chat.id,
//                           usecaseConfig: usecaseConfig,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class ChatDetailPage extends StatefulWidget {
//   final String chatId;
//   final UsecaseConfig usecaseConfig;

//   ChatDetailPage({required this.chatId, required this.usecaseConfig});

//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
//   final TextEditingController _messageController = TextEditingController();

//   List<Map<String, dynamic>> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   void _loadMessages() async {
//     final messages = await widget.usecaseConfig.getMessageUseCase!
//         .execute(widget.chatId);
//     setState(() {
//       _messages = messages;
//     });
//   }

//   void _sendMessage(String message) async {
//     await widget.usecaseConfig.sendMessageUsecase!
//         .execute(widget.chatId, message);
//     _messageController.clear();
//     _loadMessages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat ID: ${widget.chatId}'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return ListTile(
//                   title: Text(message['message']),
//                   subtitle: Text('Timestamp: ${message['timestamp']}'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     onChanged: (value) {
//                       // Puedes guardar el mensaje en un estado local
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Escribe un mensaje...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     final message = _messageController.text.trim();
//                     if (message.isNotEmpty) {
//                       _sendMessage(message);
//                     }
//                   },
//                   child: Text('Enviar'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
    );
  }
}
