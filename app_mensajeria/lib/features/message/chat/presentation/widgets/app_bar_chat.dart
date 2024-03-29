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
  final String apiURI = 'https://77d5-2806-2f0-8161-f0b5-e03c-cf12-7740-c852.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  backgroundImage: Image.network(apiURI + widget.img).image,
                  radius: 34,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.415,
                      child: Text(
                        widget.name,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? DarkModeColors.textColorTitles
                              : LightModeColors.textColorTitles,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.415,
                      child: Text(
                        widget.data,
                        softWrap: false,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? DarkModeColors.textColorTitles
                                : LightModeColors.textColorTitles),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
