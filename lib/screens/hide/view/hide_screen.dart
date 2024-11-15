import 'dart:io';

import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HideScreen extends StatefulWidget {
  const HideScreen({super.key});

  @override
  State<HideScreen> createState() => _HideScreenState();
}

class _HideScreenState extends State<HideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hide"),
      ),
      body: ListView.builder(
        itemCount: context.watch<HomeProvider>().hideList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              foregroundImage: FileImage(
                File(context.watch<HomeProvider>().hideList[index].image ??
                    "00"),
              ),
            ),
            subtitle: Text(
                "${context.watch<HomeProvider>().hideList[index].contact}"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            title:
                Text("${context.watch<HomeProvider>().hideList[index].name}"),
            onLongPress: () {
              context
                  .read<HomeProvider>()
                  .unhideContact(context.read<HomeProvider>().hideList[index]);

              Navigator.pop(context);
            },
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.hidedDetailPage,
                arguments: context.read<HomeProvider>().hideList[index],
              );
            },
          );
        },
      ),
    );
  }
}
