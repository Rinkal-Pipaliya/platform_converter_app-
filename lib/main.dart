import 'package:contact_app/routes/routes.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:contact_app/screens/profile/provider/profile_provider.dart';
import 'package:contact_app/utils/theme_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProfileProvider(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return value.isAndroid
              ? MaterialApp(
                  theme: context.watch<ProfileProvider>().darkMode
                      ? ThemeData.dark()
                      : ThemeData.light(), // darkTheme: AppTheme.darkTheme,
                  routes: AppRoutes.routes,
                  debugShowCheckedModeBanner: false,
                )
              : CupertinoApp(
                  theme: CupertinoThemeData(
                    brightness: context.watch<ProfileProvider>().darkMode
                        ? Brightness.light
                        : Brightness.dark,
                  ),
                  debugShowCheckedModeBanner: false,
                  routes: IosRoutes.routes,
                );
        },
      ),
    );
  }
}
