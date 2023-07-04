import 'package:app_mensajeria/features/message/chat/presentation/pages/chat_defaul.dart';
import 'package:app_mensajeria/usecase_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../styles.dart';
import '../../domain/entities/chats.dart';

class ChatsList extends StatefulWidget {
  final String userFire;
  final String name;
  final String data;
  final String img;
  final String userRecp;

  const ChatsList(
      {required this.userFire,
      required this.name,
      required this.data,
      required this.img,
      required this.userRecp,
      super.key});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  String apiURI = 'https://3373-187-188-32-68.ngrok-free.app';
  final UsecaseConfig usecaseConfig = UsecaseConfig();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? DarkModeColors.backgroundColor
          : LightModeColors.backgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            children: [
              Container(
                  child: FutureBuilder<List<Chats>>(
                future: usecaseConfig.getChatsUsecase!.execute(widget.userFire),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar los chats'));
                  } else {
                    final chats = snapshot.data ?? [];

                    return SingleChildScrollView(
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          final messageContent = chat.messages['content'];
                          final type = chats[index].messages['type'];
                          final timestamp = chat.messages['timestamp'];
                          print("hola aqui es  la prueba");
                          print(chat.id);

                          DateTime dateTime =
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.tryParse(timestamp) ?? 00);
                          int hour = dateTime.hour;
                          int minute = dateTime.minute;
                          int hour12 = hour > 12 ? hour - 12 : hour;
                          String amPm = hour >= 12 ? 'PM' : 'AM';

                          if (chat.userEmisorId == widget.userRecp ||
                              chat.userReceptorId == widget.userRecp) {
                            final ident = widget.name;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: GestureDetector(
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color.fromARGB(
                                                255, 20, 20, 20)
                                            : const Color.fromARGB(
                                                255, 182, 182, 182),
                                        spreadRadius: 0.75,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      )
                                    ],
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? DarkModeColors.detailColor
                                        : LightModeColors.detailColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: CircleAvatar(
                                            backgroundImage: Image.network(
                                                    apiURI + widget.img)
                                                .image,
                                            radius: 28,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    ident,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  // Text(type),
                                                  buildMessageContent(
                                                      type, messageContent),
                                                  Text(
                                                    '$hour12 : $minute  $amPm',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PageChat(
                                                name: widget.name,
                                                data: widget.data,
                                                img: widget.img,
                                                userRecp: widget.userRecp,
                                                // id: chat.id,
                                              )));
                                },
                              ),
                            );
                          }
                          return Container();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5);
                        },
                      ),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageContent(type, messagecontent) {
    if (type == '0') {
      // Mensaje de texto
      return SizedBox(
        width: MediaQuery.of(context).size.width *
            0.5, // Ajusta el valor según tus necesidades
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            messagecontent,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
        ),
      );
    } else if (type == '1') {
      return const Text("Imagen",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300));
      // Mensaje de imagen
    } else if (type == '3') {
      return const Text("Video",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300));
      // Mensaje de video
    } else if (type == '4') {
      // Mensaje de gif
      return const Text("Gif",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300));
    } else if (type == '2') {
      // Mensaje de audio
      return const Text("Audio",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300));
    } else if (type == '5') {
      // Mensaje de audio
      return const Text("Archivo",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300));
    } else {
      // Tipo de mensaje desconocido
      return Container();
    }
  }
}
