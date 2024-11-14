import 'dart:io';

import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/edit/view/edit_ios.dart';
import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailIosScreen extends StatefulWidget {
  const DetailIosScreen({super.key});

  @override
  State<DetailIosScreen> createState() => _DetailIosScreenState();
}

class _DetailIosScreenState extends State<DetailIosScreen> {
  String? imagePath;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Detail"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.back),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.read<HomeProvider>().hideContact(model);
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.lock),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Share.share(
                    "Name: ${nameController.text}\nContact: ${contactController.text}");
              },
              child: const Icon(CupertinoIcons.share),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pushNamed(context, IosRoutes.editPage,
                    arguments: model);
              },
              child: const Icon(CupertinoIcons.pencil),
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
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
          20.h,
          CupertinoListTile(
            title: const Text("Name"),
            subtitle: Text(model.name!),
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.person),
              onPressed: () {
                launchUrl(
                  Uri.parse("https://wa.me:${nameController.text}"),
                );
              },
            ),
          ),
          20.h,
          CupertinoListTile(
            title: const Text("Contact"),
            subtitle: Text(model.contact!),
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.phone),
              onPressed: () {
                launchUrl(
                  Uri.parse("tel:${contactController.text}"),
                );
              },
            ),
          ),
          20.h,
          CupertinoListTile(
            title: const Text("Email"),
            subtitle: Text(model.email!),
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.mail),
              onPressed: () {
                launchUrl(
                  Uri.parse("mailto:${emailController.text}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
