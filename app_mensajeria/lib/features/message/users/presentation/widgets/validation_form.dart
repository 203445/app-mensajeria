import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidationForm extends StatelessWidget {
  const ValidationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.165,
            child: TextFormField(
              onSaved: (pin1) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 23, 23, 23)
                    : const Color.fromARGB(255, 245, 245, 245),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 129, 78, 192),
                    width: 2.0,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.headline4,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.15,
            child: TextFormField(
              onSaved: (pin2) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 23, 23, 23)
                    : const Color.fromARGB(255, 245, 245, 245),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 129, 78, 192),
                    width: 2.0,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.headline4,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.15,
            child: TextFormField(
              onSaved: (pin3) {},
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 23, 23, 23)
                    : const Color.fromARGB(255, 245, 245, 245),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 129, 78, 192),
                    width: 2.0,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.headline4,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.15,
            child: TextFormField(
              onSaved: (pin3) {},
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 23, 23, 23)
                    : const Color.fromARGB(255, 245, 245, 245),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 129, 78, 192),
                    width: 2.0,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.headline4,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
    );
  }
}
