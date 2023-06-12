import 'dart:io';

import 'package:app_mensajeria/features/message/chat/data/models/chats_model.dart';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/usecase_config.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  final UsecaseConfig usecaseConfig = UsecaseConfig();

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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los chats'));
          } else {
            final chats = snapshot.data ?? [];
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  title: Text('Chat ID: ${chat.id}'),
                  subtitle: Text(
                      'Emisor: ${chat.userEmisorId}, Receptor: ${chat.userReceptorId}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatDetailPage(
                          chatId: chat.id,
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

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final UsecaseConfig usecaseConfig;

  ChatDetailPage({required this.chatId, required this.usecaseConfig});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();

  List<Message> _messages = [];

  String? _image;
  String? _audio;
  String? _gif;

  final ImagePicker _imagePicker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    final messages =
        await widget.usecaseConfig.getMessageUseCase!.execute(widget.chatId);
    setState(() {
      _messages = messages
          .map((message) =>
              Message(type: message.type, content: message.content))
          .toList();
    });
  }

  void _sendMessage(Message message) async {
    await widget.usecaseConfig.sendMessageUsecase!
        .execute(widget.chatId, message.content, message.type as int);
    _messageController.clear();
    _loadMessages();
  }

  void _showAttachmentOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adjuntar archivo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _attachImage();
                  Navigator.pop(context);
                },
                child: Text('Adjuntar imagen'),
              ),
              ElevatedButton(
                onPressed: () {
                  _attachAudio();
                  Navigator.pop(context);
                },
                child: Text('Adjuntar audio'),
              ),
              ElevatedButton(
                onPressed: () {
                  _attachGif();
                  Navigator.pop(context);
                },
                child: Text('Adjuntar GIF'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _attachImage() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      String url = await widget.usecaseConfig.uploadMediaUseCase!
          .execute('images/${xFile.name}', File(xFile.path));
      Message message = Message(type: MessageType.image, content: url);
      _sendMessage(message);
    }
  }

  void _attachAudio() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'], // Extensiones permitidas
    );

    if (filePickerResult != null) {
      String url = await widget.usecaseConfig.uploadMediaUseCase!.execute(
        'audios/${filePickerResult.files.single.name}',
        File(filePickerResult.files.single.path!),
      );

      Message message = Message(type: MessageType.audio, content: url);
      _sendMessage(message);
    }
  }

  void _attachGif() async {
    XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      String url = await widget.usecaseConfig.uploadMediaUseCase!
          .execute('gifs/${xFile.name}', File(xFile.path));

      Message message = Message(type: MessageType.gif, content: url);
      setState(() {
        _gif = url;
      });
      _sendMessage(message);
    } else {
      print('No se seleccionó ningún GIF.');
    }
  }

  Widget _buildMessageWidget(Message message) {
    switch (message.type) {
      case MessageType.text:
        return Text(message.content);
      case MessageType.image:
        return Image.network(message.content);
      case MessageType.audio:
        return ElevatedButton(
          onPressed: () {
            _playAudio(message.content);
          },
          child: Text('Play Audio'),
        );
      case MessageType.video:
        return ElevatedButton(
          onPressed: () {
            _playVideo(message.content);
          },
          child: Text('Play Video'),
        );
      case MessageType.gif:
        return Text('GIF: ${message.content}');
      case MessageType.unknown:
        // TODO: Handle this case.
        break;
    }

    // Si el tipo de mensaje no es reconocido, devuelve un widget por defecto
    return Text('Mensaje no reconocido');
  }

  void _playAudio(String url) async {
    XFile? xFile = await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (xFile != null) {
      String url = await widget.usecaseConfig.uploadMediaUseCase!
          .execute('videos/${xFile.name}', File(xFile.path));
      _videoPlayerController = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  void _playVideo(String url) {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    _videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
        });
      });
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
                return _buildMessageWidget(_messages[index] as Message);
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
                  onPressed: () {
                    String text = _messageController.text.trim();
                    if (text.isNotEmpty) {
                      Message message =
                          Message(type: MessageType.text, content: text);
                      _sendMessage(message);
                    }
                  },
                  icon: Icon(Icons.send),
                ),
                IconButton(
                  onPressed: _showAttachmentOptions,
                  icon: Icon(Icons.attach_file),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _videoPlayerController != null &&
              _videoPlayerController!.value.isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _videoPlayerController!.value.isPlaying
                      ? _videoPlayerController!.pause()
                      : _videoPlayerController!.play();
                });
              },
              child: Icon(Icons.play_arrow),
            )
          : null,
    );
  }
}
