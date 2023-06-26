import 'package:app_mensajeria/features/message/chat/presentation/pages/chat_defaul.dart';
import 'package:app_mensajeria/features/message/chat/presentation/pages/chat_individual.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../../styles.dart';
import '../../../users/presentation/bloc/users_bloc.dart';
import '../../domain/entities/chats.dart';

class ChatsList extends StatefulWidget {
  final String userFire;
  // final String img;
  // final String data;
  // final String id;
  const ChatsList(
      {
        required this.userFire,
      // required this.img,
      // required this.data,
      // required this.id,
      super.key});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  String apiURI = 'https://cb2d-187-188-32-68.ngrok-free.app';

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
                          final messageTimestamp = chat.messages['timestamp'];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 7),
                            child: GestureDetector(
                              child: Container(
                                height: 85,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromARGB(255, 20, 20, 20)
                                          : Color.fromARGB(255, 182, 182, 182),
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
                                      horizontal: 25, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // state.contacts[index].name,
                                              chat.userEmisorId,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              // state.contacts[index].data,
                                              messageContent,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 4);
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
}


  // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => PageChat(
                              //             name: state.contacts[index].name,
                              //             data: state.contacts[index].data,
                              //             img: state.contacts[index].img)));
                              // print(state.contacts[index].name);

 // ListTile(
                    //   title: Text('Chat ID: ${chat.userEmisorId}'),
                    //   subtitle: Text(
                    //     'Mensaje: $messageContent, Enviado: $messageTimestamp, Receptor: ${chat.userReceptorId}',
                    //   ),
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => ChatDetailPage(
                    //           chatId: 'AvdViv2isUzZ178FM6Cc',
                    //           usecaseConfig: usecaseConfig,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );

                     // Padding(
                                    //   padding: const EdgeInsets.only(right: 15),
                                    //   child: CircleAvatar(
                                    //     backgroundImage: Image.network(apiURI +
                                    //             snapshot.contacts[index].img)
                                    //         .image,
                                    //     radius: 28,
                                    //   ),
                                    // ),