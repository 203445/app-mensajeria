import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.395,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/img/test_profile.jpg'),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nombre",
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? DarkModeColors.detailColor
                    : LightModeColors.detailColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Información",
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? DarkModeColors.detailColor
                    : LightModeColors.detailColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
