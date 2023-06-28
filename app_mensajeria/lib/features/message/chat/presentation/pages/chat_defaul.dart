import 'dart:convert';
import 'dart:io';
import 'package:app_mensajeria/features/message/chat/domain/entities/chats.dart';
import 'package:app_mensajeria/features/message/chat/presentation/widgets/app_bar_chat.dart';
import 'package:app_mensajeria/features/message/chat/presentation/widgets/messages_bubble.dart';
import 'package:app_mensajeria/usecase_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chats_model.dart';

class PageChat extends StatefulWidget {
  final String name;
  final String data;
  final String img;
  final String userRecp;
  // final String id;
  const PageChat({
    Key? key,
    required this.name,
    required this.data,
    required this.img,
    required this.userRecp,
    // required this.id
  }) : super(key: key);

  @override
  State<PageChat> createState() => _HomePageState();
}

class _HomePageState extends State<PageChat> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final UsecaseConfig usecaseConfig = UsecaseConfig();
  File? _selectedImage;
  File? _selectedVideo;
  File? _selectedAudio;
  File? _selectedGif;
  late String chatId = '';

  @override
  void initState() {
    super.initState();
    _getChatId();
    _loadMessages();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _getChatId() async {
    List<Chats> chatList =
        await usecaseConfig.getChatsUsecase!.execute(widget.userRecp);
    if (chatList.isNotEmpty) {
      setState(() {
        chatId = chatList[0].id;
        print(chatId);
      });
    } else {
      setState(() {
        chatId = ''; // Valor predeterminado si no hay chats en la lista
      });
    }
  }

  Future<void> _loadMessages() async {
    if (chatId.isNotEmpty) {
      final messages = await usecaseConfig.getMessageUseCase!.execute(chatId);
    } else {
      print("no hay nada para mostrar");
    }
  }

  Future<void> _selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      _selectedImage = File(result.files.single.path!);
      String imagePath = result.files.single.path!;
      String imageUrl = await usecaseConfig.uploadMediaUseCase!
          .execute('images/${result.files.single.name}', File(imagePath));
      print(imageUrl);

      MessageType messageType = MessageType.image;
      _sendMessage(messageType, imageUrl);

      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  Future<void> _selectVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      _selectedVideo = File(result.files.single.path!);
      String videoPath = result.files.single.path!;
      String videoUrl = await usecaseConfig.uploadMediaUseCase!
          .execute('videos/${result.files.single.name}', File(videoPath));
      print(videoUrl);

      MessageType messageType = MessageType.video;
      _sendMessage(messageType, videoUrl);

      setState(() {
        _selectedVideo = File(videoPath);
      });
    }
  }

  Future<void> _selectAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      _selectedAudio = File(result.files.single.path!);
      String audioPath = result.files.single.path!;
      String audioUrl = await usecaseConfig.uploadMediaUseCase!
          .execute('audios/${result.files.single.name}', File(audioPath));
      print(audioUrl);

      MessageType messageType = MessageType.audio;
      _sendMessage(messageType, audioUrl);

      setState(() {
        _selectedAudio = File(audioPath);
      });
    }
  }

  Future<void> _selectGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );

    if (result != null) {
      _selectedGif = File(result.files.single.path!);
      String gifPath = result.files.single.path!;
      String gifUrl = await usecaseConfig.uploadMediaUseCase!
          .execute('gifs/${result.files.single.name}', File(gifPath));
      print(gifUrl);

      MessageType messageType = MessageType.gif;
      _sendMessage(messageType, gifUrl);

      setState(() {
        _selectedGif = File(gifPath);
      });
    }
  }

  Future<void> _sendMessage(MessageType messageType, String videoUrl) async {
    print("print aqui");
    MessageType messageType =
        MessageType.text; // Valor predeterminado o tipo de mensaje
    if (_selectedImage != null) {
      messageType = MessageType.image;
      // Enviar imagen
      // ...
    } else if (_selectedVideo != null) {
      messageType = MessageType.video;
      // Enviar video
      // ...
    } else if (_selectedAudio != null) {
      messageType = MessageType.audio;
      // Enviar audio
      // ...
    } else if (_selectedGif != null) {
      messageType = MessageType.gif;
      // Enviar GIF
      // ...
    } else {
      messageType = MessageType.text;
      // Enviar mensaje de texto
      // ...
    }
    List<ChatModel> chatList = await usecaseConfig.createChatsUsecase!
        .execute(currentUser?.uid, widget.userRecp);

    for (var chat in chatList) {
      String id = chat.id;
      String userEmisorId = chat.userEmisorId;
      String userReceptorId = chat.userReceptorId;
      Map<String, dynamic> messages = chat.messages;

      // Hacer algo con los datos de cada chat
      // Por ejemplo, imprimirlos
      print('ID del chat: $id');
      print('ID del usuario emisor: $userEmisorId');
      print('ID del usuario receptor: $userReceptorId');
      print('Mensajes: $messages');
      await usecaseConfig.sendMessageUsecase!
          .execute(id, videoUrl, messageType.intValue, currentUser!.uid);
    }

    _textController.clear();
    _loadMessages();
    setState(() {
      _selectedImage = null;
      _selectedVideo = null;
      _selectedAudio = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    Future<bool> onWillPop() async {
      return false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? DarkModeColors.back
                : LightModeColors.backgroundColor,
            elevation: 5,
            toolbarHeight: 110,
            leading: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  iconSize: 25,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.textColorTitles
                      : LightModeColors.textColorTitles,
                  tooltip: 'Salir',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            }),
            // automaticallyImplyLeading: false,
            title: AppBarWidgetChats(
                name: widget.name, img: widget.img, data: widget.data),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? DarkModeColors.backgroundColor
              : LightModeColors.backgroundColor,
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Chats>>(
                  future: usecaseConfig.getChatIdUsecase!
                      .execute(currentUser?.uid, widget.userRecp)
                      .then((chatId) {
                    if (chatId != null) {
                      return usecaseConfig.getMessageUseCase!.execute(chatId);
                    } else {
                      return Future.value([]);
                    }
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.accentColor
                              : LightModeColors.accentColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final messages = snapshot.data ??
                          []; // Si los mensajes son nulos, usa una lista vacía
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: messages.length,
                        itemBuilder: (ctx, item) {
                          final chat = messages[item].messages;
                          final messageId = chat.keys
                              .toList()[0]; // Obtener el ID del mensaje
                          final message = chat[messageId];
                          final content = message['content'];
                          final type = message['type'];
                          final uid = message['userId'];
                          final isEmisor = currentUser!.uid == uid;
                          return Message(
                            text: message['type'] == 0 ? content : '',
                            typeimage: message['type'] == 1 ? content : '',
                            typevideo: message['type'] == 3 ? content : '',
                            typeaudio: message['type'] == 2 ? content : '',
                            typegif: message['type'] == 4 ? content : '',
                            isCurrentUser: isEmisor,
                            // alignment: alignment,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? DarkModeColors.textfill
                                  : LightModeColors.textbubble,
                          hintText: 'Escribe un mensaje...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(20, 590, 0, 0),
                          items: [
                            PopupMenuItem<String>(
                              value: 'image',
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _selectImage,
                                    icon: Icon(Icons.image),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'video',
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _selectVideo,
                                    icon: Icon(Icons.video_library),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'audio',
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _selectAudio,
                                    icon: Icon(Icons.music_note),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'gif',
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: _selectGif,
                                    icon: SvgPicture.asset(
                                      'assets/icons/gif_icons.svg', // Ruta del archivo SVG del icono de GIF
                                      width:
                                          15, // Ajusta el tamaño del icono según tus necesidades
                                      height: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      child: Transform.rotate(
                        angle: 5 / 8,
                        child: const Icon(
                          Icons.attach_file_outlined, size: 26,
                          //_sendMessage
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      onPressed: () async {
                        String text = _textController.text.trim();
                        if (text.isNotEmpty) {
                          MessageType messageType = MessageType.text;
                          _sendMessage(messageType, text);
                        }
                      },
                      child: const Icon(
                        Icons.send, size: 26, //_sendMessage
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
