import 'package:flutter/material.dart';

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
              backgroundColor: const Color(0xffA569EF),
              side: const BorderSide(width: 1.5, color: Color(0xffA569EF)),
              elevation: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              textButton,
              style: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 241, 241, 241)),
            ),
          )),
    );
  }
}
