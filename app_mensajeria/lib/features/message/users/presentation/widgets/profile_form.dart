import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_mensajeria/styles.dart';
import 'package:image_picker/image_picker.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  File? _profileimage;

  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img == null) { return; }

    setState(() {
      _profileimage = File(img.path);
    });

    print(_profileimage);
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController userdataController = TextEditingController();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                CircleAvatar(
                radius: 76,
                backgroundImage: _profileimage != null ? Image.file(_profileimage!).image : Image.asset("assets/images/default-user.png").image
                ),

                Positioned(
                  right: -1,
                  bottom: -3,
                  child: FloatingActionButton.small(
                    onPressed: () { getImage(); },

                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? DarkModeColors.accentColor
                      : LightModeColors.accentColor,
                    child: const Icon(Icons.edit, color: Color.fromARGB(236, 255, 255, 255)),
                  )
                )
              ]
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
