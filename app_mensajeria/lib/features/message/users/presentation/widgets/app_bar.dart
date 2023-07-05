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
  final String apiURI = 'https://a60e-187-188-32-68.ngrok-free.app';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
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
                height: MediaQuery.of(context).size.width * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? DarkModeColors.textColorTitles
                            : LightModeColors.textColorTitles,
                      ),
                    ),
                    Text(
                      widget.user.data,
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
