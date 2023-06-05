import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

class MainButton extends StatelessWidget {
  final String textButton;
  const MainButton({Key? key, required this.textButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.08,
      child: OutlinedButton(
          onPressed: () => {},
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? DarkModeColors.accentColor
                  : LightModeColors.accentColor,
              side: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.accentColor
                      : LightModeColors.accentColor),
              elevation: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              textButton,
              style: const TextStyle(
                  fontSize: 22, color: Color(0xFFF1F1F1)),
            ),
          )),
    );
  }
}
