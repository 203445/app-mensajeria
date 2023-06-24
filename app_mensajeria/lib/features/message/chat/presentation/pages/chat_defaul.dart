import 'dart:io';

import 'package:app_mensajeria/features/message/chat/presentation/widgets/app_bar_chat.dart';
// import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageChat extends StatefulWidget {
  final String name;
  final String data;
  final String img;
  const PageChat(
      {Key? key, required this.name, required this.data, required this.img})
      : super(key: key);

  @override
  State<PageChat> createState() => _HomePageState();
}

class _HomePageState extends State<PageChat> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  File? _selectedImage;
  File? _selectedVideo;
  File? _selectedAudio;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      _selectedImage = File(result.files.single.path!);
    }
  }

  Future<void> _selectVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      _selectedVideo = File(result.files.single.path!);
    }
  }

  Future<void> _selectAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      _selectedAudio = File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    // tabController.addListener(() {
    //   context
    //       .read<UsersBloc>()
    //       .add(HomeNavegation(id: widget.user.id, index: tabController.index));
    // });

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
                padding: const EdgeInsets.symmetric(horizontal: 13),
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
              Expanded(child: Text("hola")),
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
                          fillColor: DarkModeColors.textfill,
                          hintText: 'Escribe un mensaje...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: _selectImage,
                    //   icon: Icon(Icons.image),
                    // ),
                    // IconButton(
                    //   onPressed: _selectVideo,
                    //   icon: Icon(Icons.video_library),
                    // ),
                    // IconButton(
                    //   onPressed: _selectAudio,
                    //   icon: Icon(Icons.music_note),
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      onPressed: () {
                        _options();
                      },
                      child: const Icon(
                        Icons.attach_file_outlined, size: 25,
                        //_sendMessage
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      onPressed: () {},
                      child: const Icon(
                        Icons.send, size: 25, //_sendMessage
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
          // Text("hello")
          //BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
          //   if (state is LoadedContacts ||
          //       state is LoadedChats ||
          //       state is Loading ||
          //       state is LoadedPage ||x
          //       state is UserCreated ||
          //       state is UserEdited) {
          // Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //     child: SizedBox(
          //         width: double.infinity,
          //         height: MediaQuery.of(context).size.height * 0.725,
          //         child: const Column(
          //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text("Chats contenido"),
          //           ],
          //         ))) //AGREGAR COMPONENTE DE VISTA DE CHATS
          //               SizedBox(
          //                 width: double.infinity,
          //                 height: MediaQuery.of(context).size.height,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     ContactsList(),
          //                     Align(
          //                       alignment: Alignment.bottomRight,
          //                       child: FloatingActionButton(
          //                         onPressed: () {
          //                           Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       AddContactPage(
          //                                         id: widget.user.id,
          //                                       )));
          //                         },
          //                         backgroundColor:
          //                             Theme.of(context).brightness ==
          //                                     Brightness.dark
          //                                 ? DarkModeColors.accentColor
          //                                 : LightModeColors.accentColor,
          //                         child: const Icon(
          //                           Icons.add,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           )),
          //     );
          //   } else if (state is Error) {
          //     return const ErrorView();
          //   } else {
          //     return Container();
          //   }
          // })
          ),
    );
  }

  _options() {
    print(currentUser!.uid);
  }
}
