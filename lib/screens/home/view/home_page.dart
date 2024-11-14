import 'dart:io';
import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider providerW;
  late HomeProvider providerR;
  @override
  Widget build(BuildContext context) {
    providerW = context.watch<HomeProvider>();
    providerR = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Home Page"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.profilePage);
          },
          icon: const Icon(Icons.person),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool isLock = await context.read<HomeProvider>().openLock();
              if (isLock) {
                Navigator.pushNamed(context, AppRoutes.hidePage);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Lock not found"),
                    behavior: SnackBarBehavior.fixed,
                  ),
                );
              }
            },
            icon: const Icon(Icons.lock),
          ),
          Switch(
            activeColor: Colors.grey.shade100,
            value: providerW.isAndroid,
            onChanged: (value) {
              providerR.changePlatform();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: context.watch<HomeProvider>().contactList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              foregroundImage: FileImage(
                File(context.watch<HomeProvider>().contactList[index].image ??
                    "00"),
              ),
            ),
            subtitle: Text(
                "${context.watch<HomeProvider>().contactList[index].contact}"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            onLongPress: () {
              context.read<HomeProvider>().deleteContact(index);
            },
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detailPage,
                arguments: context.read<HomeProvider>().contactList[index],
              );
            },
            title: Text(
                "${context.watch<HomeProvider>().contactList[index].name}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addContactPage);
        },
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
