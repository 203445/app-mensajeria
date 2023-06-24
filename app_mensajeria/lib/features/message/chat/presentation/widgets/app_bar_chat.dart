import 'package:flutter/material.dart';

import '../../../../../styles.dart';

class AppBarWidgetChats extends StatefulWidget {
  final String name;
  final String img;
  final String data;
  const AppBarWidgetChats(
      {Key? key, required this.name, required this.img, required this.data})
      : super(key: key);

  @override
  State<AppBarWidgetChats> createState() => _AppBarWidgetChats();
}

class _AppBarWidgetChats extends State<AppBarWidgetChats> {
  final String apiURI = 'https://1531-187-188-32-68.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundImage: Image.network(apiURI + widget.img).image,
                  radius: 34,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? DarkModeColors.textColorTitles
                            : LightModeColors.textColorTitles,
                      ),
                    ),
                    Text(
                      widget.data,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.textColorTitles
                              : LightModeColors.textColorTitles),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}