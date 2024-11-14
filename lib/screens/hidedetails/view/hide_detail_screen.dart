import 'dart:io';

import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HideDetailScreen extends StatefulWidget {
  const HideDetailScreen({super.key});

  @override
  State<HideDetailScreen> createState() => _HideDetailScreenState();
}

class _HideDetailScreenState extends State<HideDetailScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController contactController = TextEditingController();

    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hide Detail"),
        actions: [
          IconButton(
            onPressed: () {
              Share.share("${model.name}\n${model.contact}");
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              nameController.text = model.name!;
              emailController.text = model.email!;
              contactController.text = model.contact!;

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edite Contact"),
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
                              hintText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: contactController,
                            decoration: const InputDecoration(
                              hintText: "Contact",
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
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              ContactModel model = ContactModel(
                                name: nameController.text,
                                email: emailController.text,
                                contact: contactController.text,
                              );
                              context
                                  .read<HomeProvider>()
                                  .hideUpdateContact(model);
                              Navigator.pop(context);
                            },
                            child: const Text("Update")),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: FileImage(
              File(
                model.image ?? "00".substring(0, 1).toUpperCase(),
              ),
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
          5.h,
          ListTile(
            trailing: IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("mailto:${model.email}"),
                );
              },
              icon: const Icon(Icons.alternate_email_outlined),
            ),
            title: const Text("Email"),
            subtitle: Text(model.email!),
          ),
          5.h,
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
    );
  }
}
