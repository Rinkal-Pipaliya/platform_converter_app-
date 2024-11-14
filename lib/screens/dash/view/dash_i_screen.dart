import 'package:contact_app/screens/contact/view/add_contact_ios_screen.dart';

import 'package:contact_app/screens/home/view/home_ios_screen.dart';
import 'package:contact_app/screens/profile/view/profile_ios_screen.dart';
import 'package:flutter/cupertino.dart';

class DashIScreen extends StatefulWidget {
  const DashIScreen({super.key});

  @override
  State<DashIScreen> createState() => _DashIScreenState();
}

class _DashIScreenState extends State<DashIScreen> {
  List<Widget> screens = [
    const HomeIosScreen(),
    const AddContactIosScreen(),
    const IosProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return screens[index];
      },
    );
  }
}
