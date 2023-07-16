import 'package:flutter/material.dart';
import '../../../../../styles.dart';
import '../../domain/entities/users.dart';

class AppBarWidget extends StatefulWidget {
  final User user;
  const AppBarWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final String apiURI = 'https://77d5-2806-2f0-8161-f0b5-e03c-cf12-7740-c852.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: SizedBox(
          //height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  backgroundImage:
                      Image.network(apiURI + widget.user.img).image,
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
                        widget.user.name,
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
                        widget.user.data,
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
