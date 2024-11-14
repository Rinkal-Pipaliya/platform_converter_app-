import 'dart:io';
import 'package:contact_app/screens/contact/provider/contact_provider.dart';
import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class IosEditPage extends StatefulWidget {
  const IosEditPage({super.key});

  @override
  State<IosEditPage> createState() => _IosEditPageState();
}

class _IosEditPageState extends State<IosEditPage> {
  String? imagePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactModel iosEditContact =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    nameController.text = iosEditContact.name!;
    phoneController.text = iosEditContact.contact!;
    emailController.text = iosEditContact.email!;
    imagePath = iosEditContact.image;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xff384e78),
        middle: const Text(
          'Edit Contact',
          style: TextStyle(color: CupertinoColors.white, fontSize: 20),
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(10),
          onPressed: () {
            iosEditContact.name = nameController.text;
            iosEditContact.contact = phoneController.text;
            iosEditContact.email = emailController.text;
            iosEditContact.image = imagePath;

            context.read<ContactProvider>().updateContact(iosEditContact);

            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 100,
                  );

                  if (file != null) {
                    setState(() {
                      imagePath = file.path;
                    });
                  }
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : const NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                            ) as ImageProvider,
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: CupertinoColors.systemGrey,
                        radius: 25,
                        child: Icon(
                          CupertinoIcons.camera,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            CupertinoTextField(
              controller: nameController,
              placeholder: "Name",
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(12),
              ),
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.person,
                    color: CupertinoColors.systemGrey),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              controller: phoneController,
              placeholder: "Phone",
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(12),
              ),
              keyboardType: TextInputType.phone,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.phone,
                    color: CupertinoColors.systemGrey),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoTextField(
              controller: emailController,
              placeholder: "Email",
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(12),
              ),
              keyboardType: TextInputType.emailAddress,
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.mail,
                    color: CupertinoColors.systemGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
