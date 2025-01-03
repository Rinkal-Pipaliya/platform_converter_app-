import 'package:contact_app/screens/contact/view/add_contact_ios_screen.dart';
import 'package:contact_app/screens/contact/view/add_contact_page.dart';
import 'package:contact_app/screens/counter/view/counter_screen.dart';
import 'package:contact_app/screens/dash/view/dash_i_screen.dart';
import 'package:contact_app/screens/detail/view/detail_ios_screen.dart';
import 'package:contact_app/screens/detail/view/detail_screen.dart';
import 'package:contact_app/screens/edit/view/edit_ios.dart';
import 'package:contact_app/screens/favorite/favorite_screen.dart';
import 'package:contact_app/screens/hide/view/hide_ios_screen.dart';
import 'package:contact_app/screens/hide/view/hide_screen.dart';
import 'package:contact_app/screens/hidedetails/view/hide_detail_screen.dart';
import 'package:contact_app/screens/home/view/home_ios_screen.dart';
import 'package:contact_app/screens/home/view/home_page.dart';
import 'package:contact_app/screens/intro/view/intro_screen.dart';
import 'package:contact_app/screens/profile/view/profile_ios_screen.dart';
import 'package:contact_app/screens/profile/view/profile_screen.dart';
import 'package:contact_app/screens/splashPage/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splashPage = '/';
  static String introPage = 'intro_page';
  static String homePage = 'home_page';
  static String addContactPage = 'add_contact_page';
  static String counterPage = 'counter_page';
  static String detailPage = 'detail_page';
  static String hidePage = 'hide_page';
  static String hidedDetailPage = 'hide_detail_page';
  static String favoritePage = 'favorite_page';
  static String profilePage = 'profile_page';

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.splashPage: (_) => const SplashPage(),
    AppRoutes.introPage: (_) => const Introduction(),
    AppRoutes.homePage: (_) => const HomePage(),
    AppRoutes.addContactPage: (_) => const AddContactPage(),
    AppRoutes.counterPage: (_) => const CounterScreen(),
    AppRoutes.detailPage: (_) => const DetailScreen(),
    AppRoutes.hidePage: (_) => const HideScreen(),
    AppRoutes.hidedDetailPage: (_) => const HideDetailScreen(),
    AppRoutes.favoritePage: (_) => const FavoriteScreen(),
    AppRoutes.profilePage: (_) => const ProfilePage(),
  };
}

class IosRoutes {
  static String dashPage = '/';
  static String homePage = '/home';
  static String addContactPage = '/addContactIosPage';
  static String detailPage = '/detailIosPage';
  static String hidePage = '/hideIosPage';
  static String profilePage = '/profileIosPage';
  static String editPage = '/editPage';

  static Map<String, Widget Function(BuildContext)> routes = {
    IosRoutes.dashPage: (_) => const DashIScreen(),
    IosRoutes.homePage: (_) => const HomeIosScreen(),
    IosRoutes.hidePage: (_) => const AddContactIosScreen(),
    IosRoutes.detailPage: (_) => const DetailIosScreen(),
    IosRoutes.hidePage: (_) => const HideIosScreen(),
    IosRoutes.profilePage: (_) => const IosProfilePage(),
    IosRoutes.editPage: (_) => const IosEditPage(),
  };
}
