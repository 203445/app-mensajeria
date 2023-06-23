import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../styles.dart';
import '../bloc/users_bloc.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  String apiURI =
    'https://393f-2806-2f0-8161-f0b5-ec86-f19d-9d4c-c541.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? DarkModeColors.backgroundColor
          : LightModeColors.backgroundColor,
      child: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DarkModeColors.accentColor
                  : LightModeColors.accentColor,
            ),
          );
        } else if (state is LoadedContacts) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.625,
                    child: ListView.separated(
                      itemCount: state.contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                          child: Container(
                            height: 85,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:  [
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: CircleAvatar(
                                      backgroundImage: Image.network(apiURI +
                                              state.contacts[index].img)
                                          .image,
                                      radius: 28,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.contacts[index].name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          state.contacts[index].data,
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
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 4);
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.red,
          );
        }
      }),
    );
  }
}