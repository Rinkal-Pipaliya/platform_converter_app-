import 'package:flutter/cupertino.dart';

class HideDetailIosScreen extends StatefulWidget {
  const HideDetailIosScreen({super.key});

  @override
  State<HideDetailIosScreen> createState() => _HideDetailIosScreenState();
}

class _HideDetailIosScreenState extends State<HideDetailIosScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Placeholder(),
    );
  }
}