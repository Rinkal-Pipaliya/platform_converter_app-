import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome",
            body: "Welcome to our app",
            image: Image.asset("lib/assets/images/brand.png"),
          ),
          PageViewModel(
            title: "Welcome",
            body: "Start using our app",
            image: Image.asset("lib/assets/images/Contact.png"),
          ),
          PageViewModel(
            title: "Welcome",
            body: "Enjoy using our app",
            image: Image.asset("lib/assets/images/Contact us-bro.png"),
          ),
        ],
        done: const Text('Done'),
        next: const Text('Next'),
        skip: const Text('Skip'),
        onDone: () {
          ShareHelper shr = ShareHelper();
          shr.saveIntrostatus();
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        },
        showSkipButton: true,
      ),
    );
  }
}
