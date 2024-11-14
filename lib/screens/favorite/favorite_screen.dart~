import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                  // foregroundImage: FileImage(
                  //   File("00"),
                  // ),
                  ),
              subtitle: Text(
                  "${context.watch<HomeProvider>().favoriteList[index].contact}"),
              title: Text(
                  "${context.watch<HomeProvider>().favoriteList[index].name}"),
            );
          }),
    );
  }
}
