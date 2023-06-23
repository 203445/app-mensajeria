import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../usecase_config.dart';
import '../../data/models/chats_model.dart';
import '../../domain/entities/chats.dart';

// class ChatDetailPage extends StatefulWidget {
//   final String chatId;
//   final UsecaseConfig usecaseConfig;

//   ChatDetailPage({required this.chatId, required this.usecaseConfig});

//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
//   final TextEditingController _messageController = TextEditingController();

//   List<ChatModel> _messages = [];

//   String? _image;
//   String? _audio;
//   String? _gif;

//   final ImagePicker _imagePicker = ImagePicker();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   VideoPlayerController? _videoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _loadMessages() async {
//     final messages =
//         await widget.usecaseConfig.getMessageUseCase!.execute(widget.chatId);
//         print('aquiu');
//     print(messages);
//     setState(() {
//       _messages = messages
//           .map((message) => ChatModel(
//                 userEmisorId: message.userEmisorId,
//                 userReceptorId: message.userReceptorId,
//                 // userId: message.userId,
//                 messages: message.messages,
//                 // type: message.type,
//                 // timestamp: message.timestamp
//               ))
//           .toList();
//       // print(_messages);
//     });
//   }

//   void _sendMessage(ChatModel message) async {
//     MessageType messageType =
//         MessageType.text; // Valor predeterminado o tipo de mensaje

//     // // Verificar el tipo de mensaje y asignar el valor correcto a 'messageType'
//     // if (message.type == MessageType.image) {
//     //   messageType = MessageType.image;
//     // } else if (message.type == MessageType.audio) {
//     //   messageType = MessageType.audio;
//     // } else if (message.type == MessageType.video) {
//     //   messageType = MessageType.video;
//     // } else if (message.type == MessageType.gif) {
//     //   messageType = MessageType.gif;
//     // }

//     ChatModel newMessage = ChatModel(
//       userEmisorId: message.userEmisorId,
//       userReceptorId: message.userReceptorId,
//       messages: message.messages,
//     );

//     await widget.usecaseConfig.sendMessageUsecase!.execute(
//       widget.chatId,
//       newMessage as String,
//       messageType.index,
//       widget.chatId,
//     );
//     _messageController.clear();
//     _loadMessages();
//   }

//   void _showAttachmentOptions() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Adjuntar archivo'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   _attachImage();
//                   Navigator.pop(context);
//                 },
//                 child: Text('Adjuntar imagen'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   _attachAudio();
//                   Navigator.pop(context);
//                 },
//                 child: Text('Adjuntar audio'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   _attachGif();
//                   Navigator.pop(context);
//                 },
//                 child: Text('Adjuntar GIF'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _attachImage() async {
//     XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

//     if (xFile != null) {
//       String url = await widget.usecaseConfig.uploadMediaUseCase!
//           .execute('images/${xFile.name}', File(xFile.path));
//       print(url);
//       // // Message message = Message(type: MessageType.image, content: url);
//       // _sendMessage(message);

//       setState(() {
//         _image = url;
//       });
//     }
//   }

//   void _attachAudio() async {
//     FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp3', 'wav'], // Extensiones permitidas
//     );

//     if (filePickerResult != null) {
//       String url = await widget.usecaseConfig.uploadMediaUseCase!.execute(
//         'audios/${filePickerResult.files.single.name}',
//         File(filePickerResult.files.single.path!),
//       );

//       // Message message = Message(type: MessageType.audio, content: url);
//       // _sendMessage(message);
//     }
//   }

//   void _attachGif() async {
//     XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (xFile != null) {
//       String url = await widget.usecaseConfig.uploadMediaUseCase!
//           .execute('gifs/${xFile.name}', File(xFile.path));

//       // Message message = Message(type: MessageType.gif, content: url);
//       setState(() {
//         _gif = url;
//       });
//       // _sendMessage(message);
//     } else {
//       print('No se seleccionó ningún GIF.');
//     }
//   }

//   Widget _buildMessageWidget(ChatModel message) {
//     print('es aqyuii');
//     print(message.messages);
//     return Text(message.messages as String);
//     // switch (message.type) {
//     //   case MessageType.text:
//     //     return Text(message.content);
//     //   case MessageType.image:
//     //     return _image != null && message.content.isNotEmpty
//     //         ? Image(
//     //             image: NetworkImage(message.content),
//     //             height: 60,
//     //             width: 60,
//     //           )
//     //         : Text('s');
//     //   case MessageType.audio:
//     //     return ElevatedButton(
//     //       onPressed: () {
//     //         _playAudio(message.content);
//     //       },
//     //       child: Text('Play Audio'),
//     //     );
//     //   case MessageType.video:
//     //     return ElevatedButton(
//     //       onPressed: () {
//     //         _playVideo(message.content);
//     //       },
//     //       child: Text('Play Video'),
//     //     );
//     //   case MessageType.gif:
//     //     return Text('GIF: ${message.content}');
//     //   case MessageType.unknown:
//     //     // TODO: Handle this case.
//     //     break;
//     // }

//     // Si el tipo de mensaje no es reconocido, devuelve un widget por defecto
//     // return Text('Mensaje no reconocido');
//   }

//   void _playAudio(String url) async {
//     FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp3', 'wav'], // Extensiones permitidas
//     );

//     if (filePickerResult != null) {
//       String url = await widget.usecaseConfig.uploadMediaUseCase!.execute(
//           'videos/${filePickerResult.files.single.name}',
//           File(filePickerResult.files.single.path!));
//       setState(() {
//         _audio = url;
//       });
//     }
//   }

//   void _playVideo(String url) {
//     if (_videoPlayerController != null) {
//       _videoPlayerController!.dispose();
//     }
//     _videoPlayerController = VideoPlayerController.network(url)
//       ..initialize().then((_) {
//         setState(() {
//           _videoPlayerController!.play();
//         });
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Detail'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return _buildMessageWidget(_messages[index]);
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
//                     decoration: InputDecoration(
//                       hintText: 'Enter a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     String text = _messageController.text.trim();
//                     if (text.isNotEmpty) {
//                       // Message message =
//                       //     Message(type: MessageType.text, content: text);
//                       // _sendMessage(message);
//                     }
//                   },
//                   icon: Icon(Icons.send),
//                 ),
//                 IconButton(
//                   onPressed: _showAttachmentOptions,
//                   icon: Icon(Icons.attach_file),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: _videoPlayerController != null &&
//               _videoPlayerController!.value.isInitialized
//           ? FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   _videoPlayerController!.value.isPlaying
//                       ? _videoPlayerController!.pause()
//                       : _videoPlayerController!.play();
//                 });
//               },
//               child: Icon(Icons.play_arrow),
//             )
//           : null,
//     );
//   }
// }

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final UsecaseConfig usecaseConfig;

  ChatDetailPage({required this.chatId, required this.usecaseConfig});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();

  List<ChatModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    List<ChatModel> messages =
        await widget.usecaseConfig.getMessageUseCase!.execute(widget.chatId);
    print(messages);
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() {
    //  MessageType messageType =
//         MessageType.text; // Valor predeterminado o tipo de mensaje

//     // // Verificar el tipo de mensaje y asignar el valor correcto a 'messageType'
//     // if (message.type == MessageType.image) {
//     //   messageType = MessageType.image;
//     // } else if (message.type == MessageType.audio) {
//     //   messageType = MessageType.audio;
//     // } else if (message.type == MessageType.video) {
//     //   messageType = MessageType.video;
//     // } else if (message.type == MessageType.gif) {
//     //   messageType = MessageType.gif;
//     // }

//     ChatModel newMessage = ChatModel(
//       userEmisorId: message.userEmisorId,
//       userReceptorId: message.userReceptorId,
//       messages: message.messages,
//     );

//     await widget.usecaseConfig.sendMessageUsecase!.execute(
//       widget.chatId,
//       newMessage as String,
//       messageType.index,
//       widget.chatId,
//     );
//     _messageController.clear();
//     _loadMessages();
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      ChatModel newMessage = ChatModel(
        userEmisorId: widget
            .chatId, // Aquí debes proporcionar los IDs correctos del emisor y receptor
        userReceptorId: widget.chatId,
        messages: {
          'content': text,
          'type': 0
        }, // Ajusta esto según la estructura de tus mensajes
      );
      widget.usecaseConfig.sendMessageUsecase!.execute(widget.chatId,
          newMessage as String, widget.chatId as int, widget.chatId);
      _messageController.clear();
    }
  }

  Widget _buildMessageWidget(ChatModel message) {
    return ListTile(
      title: Text(message.messages['content']),
      subtitle: Text('Type: ${message.messages['type']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessageWidget(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
