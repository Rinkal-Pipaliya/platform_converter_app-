import 'dart:io';

import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeIosScreen extends StatefulWidget {
  const HomeIosScreen({super.key});

  @override
  State<HomeIosScreen> createState() => _HomeIosScreenState();
}

class _HomeIosScreenState extends State<HomeIosScreen> {
  late HomeProvider providerW;
  late HomeProvider providerR;
  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Home"),
        leading: CupertinoSwitch(
          value: providerW.isAndroid,
          onChanged: (value) {
            providerR.changePlatform();
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.lock),
          onPressed: () {
            Navigator.pushNamed(context, IosRoutes.hidePage);
          },
        ),
      ),
      child: Center(
        child: ListView.builder(
          itemCount: providerW.contactList.length,
          itemBuilder: (BuildContext context, int index) {
            return CupertinoListTile(
              onTap: () {
                Navigator.pushNamed(context, IosRoutes.detailPage,
                    arguments: providerW.contactList[index]);
              },
              leading: CircleAvatar(
                radius: 70,
                foregroundImage: FileImage(
                  File(providerW.contactList[index].image ?? "00"),
                ),
              ),
              subtitle: Text("${providerW.contactList[index].contact}"),
              title: Text("${providerW.contactList[index].name}"),
              trailing: CupertinoButton(
                child: const Icon(CupertinoIcons.delete_solid),
                onPressed: () {
                  providerR.deleteContact(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
