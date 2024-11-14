import 'dart:io';

import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              Share.share("${model.name}\n${model.contact}");
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              context.read<HomeProvider>().hideContact(model);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {
              nameController.text = model.name!;
              emailController.text = model.email!;
              contactController.text = model.contact!;
              updateDailog(context);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              foregroundImage: FileImage(
                File(model.image ?? "00"),
              ),
              child: Text(
                model.name ?? "00".substring(0, 1).toUpperCase(),
              ),
            ),
            ListTile(
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
              ),
              title: const Text("Name"),
              subtitle: Text(model.name!),
            ),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse("mailto:${contactController.text}"),
                  );
                },
                icon: const Icon(Icons.alternate_email_outlined),
              ),
              title: const Text("Email"),
              subtitle: Text(model.email!),
            ),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse("tel:${model.contact}"),
                  );
                },
                icon: const Icon(Icons.phone),
              ),
              title: const Text("Contact"),
              subtitle: Text(model.contact!),
            ),
          ],
        ),
      ),
    );
  }

  void updateDailog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              5.h,
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(),
                ),
              ),
              5.h,
              TextField(
                controller: contactController,
                decoration: const InputDecoration(
                  hintText: "contact",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                ContactModel model = ContactModel(
                  name: nameController.text,
                  email: emailController.text,
                  contact: contactController.text,
                );
                context.read<HomeProvider>().updateContact(model);
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
