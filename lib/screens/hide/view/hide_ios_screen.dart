import 'dart:io';

import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HideIosScreen extends StatefulWidget {
  const HideIosScreen({super.key});

  @override
  State<HideIosScreen> createState() => _HideIosScreenState();
}

class _HideIosScreenState extends State<HideIosScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Hide"),
      ),
      child: ListView.builder(
        itemCount: context.watch<HomeProvider>().hideList.length,
        itemBuilder: (BuildContext context, int index) {
          return CupertinoListTile(
            leading: CircleAvatar(
              foregroundImage: FileImage(
                File(context.watch<HomeProvider>().hideList[index].image ??
                    "00"),
              ),
            ),
            title: Text(context.watch<HomeProvider>().hideList[index].name!),
            subtitle:
                Text(context.watch<HomeProvider>().hideList[index].contact!),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.delete),
              onPressed: () {
                context.read<HomeProvider>().unhideContact(
                    context.read<HomeProvider>().hideList[index]);
                Navigator.pop(context);
              },
            ),
            onTap: () {
              Navigator.pushNamed(context, IosRoutes.detailPage,
                  arguments: context.read<HomeProvider>().hideList[index]);
            },
          );
        },
      ),
    );
  }
}
