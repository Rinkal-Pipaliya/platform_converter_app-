import 'dart:io';

import 'package:contact_app/screens/profile/provider/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class IosProfilePage extends StatefulWidget {
  const IosProfilePage({super.key});

  @override
  State<IosProfilePage> createState() => _IosProfilePageState();
}

class _IosProfilePageState extends State<IosProfilePage> {
  String? imagePath;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Profile",
          style: TextStyle(color: CupertinoColors.white, fontSize: 20),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            "Save",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () {
            // Save logic
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            GestureDetector(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100,
                );
                setState(() {
                  imagePath = file?.path;
                });
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!))
                    : const NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                      ) as ImageProvider,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: CupertinoColors.systemGrey,
                    radius: 20,
                    child: Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              controller: nameController,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              placeholder: "Enter your name",
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.person,
                    color: CupertinoColors.inactiveGray),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CupertinoListTile(
              title: const Text("Dark Mode", style: TextStyle(fontSize: 18)),
              trailing: CupertinoSwitch(
                value: context.watch<ProfileProvider>().darkMode,
                onChanged: (val) {
                  context.read<ProfileProvider>().isDark(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
