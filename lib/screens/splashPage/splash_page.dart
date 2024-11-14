import 'dart:async';

import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    ShareHelper shr = ShareHelper();
    shr.readIntrostatus().then((value) {
      Timer(const Duration(seconds: 3), () {
        if (value == true) {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.introPage);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: kIsWeb
            ? Image.network("lib/assets/gif/contact.gif")
            : Image.asset("lib/assets/gif/contact.gif"),
      ),
    );
  }
}
  