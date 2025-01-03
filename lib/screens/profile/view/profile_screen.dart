import 'package:contact_app/screens/contact/view/add_contact_ios_screen.dart';
import 'package:contact_app/screens/profile/provider/profile_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
              ),
            ),
            40.h,
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Enter Name",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            // ListTile(
            //   title: const Text("Dark Mode"),
            //   trailing: Consumer<ProfileProvider>(
            //     builder: (BuildContext context, ProfileProvider value,
            //         Widget? child) {
            //       return Switch(
            //         value: value.darkMode,
            //         onChanged: (val) {
            //           context.read<ProfileProvider>().isDark(val);
            //         },
            //       );
            //     },
            //   ),
            // ),
            ListTile(
              title: Text("Dark"),
              trailing: Switch(
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
