import 'package:app_mensajeria/features/message/chat/presentation/widgets/chats_list.dart';
import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';
import 'package:app_mensajeria/features/message/users/presentation/bloc/users_bloc.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/add_contact_page.dart';
import 'package:app_mensajeria/features/message/users/presentation/pages/edit_profile_page.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/app_bar.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/contacts_list.dart';
import 'package:app_mensajeria/features/message/users/presentation/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AQUI DEBO HACER UN GET ID DEPENDIENDO A LOS CHATS DEL USUARIO
class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      context
          .read<UsersBloc>()
          .add(HomeNavegation(id: widget.user.id, index: tabController.index));
    });

    Future<bool> onWillPop() async {
      return false;
    }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? DarkModeColors.backgroundColor
                : LightModeColors.backgroundColor,
            elevation: 0,
            toolbarHeight: 165,
            automaticallyImplyLeading: false,
            title: AppBarWidget(user: widget.user),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: IconButton(
                  icon: const Icon(Icons.edit),
                  iconSize: 22,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.textColorTitles
                      : LightModeColors.textColorTitles,
                  tooltip: 'Editar perfil',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(user: widget.user)));
                  },
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size(0, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.detailColor
                      : LightModeColors.detailColor,
                ),
                width: MediaQuery.of(context).size.width * 0.515,
                height: MediaQuery.of(context).size.height * 0.045,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: TabBar(
                      labelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.textColorTitles
                              : LightModeColors.textColorTitles,
                      unselectedLabelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.textColor
                              : LightModeColors.textColor,
                      controller: tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? DarkModeColors.accentColor
                            : LightModeColors.accentColor,
                      ),
                      tabs: const [
                        Tab(
                          text: "Chats",
                        ),
                        Tab(
                          text: "Contactos",
                        )
                      ]),
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? DarkModeColors.backgroundColor
              : LightModeColors.backgroundColor,
          body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
            if (state is LoadedContacts ||
                state is LoadedChats ||
                state is Loading ||
                state is LoadedPage ||
                state is UserCreated ||
                state is UserEdited) {
              if (state is LoadedContacts) {
                final contacts = (state).contacts;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ListView(
                            children: contacts.map((contact) {
                              print(contact.name);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: ChatsList(
                                  userFire: widget.user.firebaseId,
                                  name: contact.name,
                                  data: contact.data,
                                  img: contact.img,
                                  userRecp: contact.firebaseId,
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContactsList(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddContactPage(
                                                    id: widget.user.id,
                                                  )));
                                    },
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? DarkModeColors.accentColor
                                            : LightModeColors.accentColor,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              } else if (state is Error) {
                return const ErrorView();
              } else {
                return Container();
              }
            } else if (state is Error) {
              return const ErrorView();
            } else {
              return Container();
            }
          })),
    );
  }
}
