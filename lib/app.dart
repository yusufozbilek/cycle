import 'package:cycle/Pages/SettingsPage/profilephotoedit.dart';
import 'package:cycle/Pages/SettingsPage/settings%20page.dart';
import 'package:cycle/Pages/googlemapspage.dart';
import 'package:cycle/Pages/homepage.dart';
import 'package:cycle/Pages/loginpage.dart';
import 'package:cycle/Pages/registerpage.dart';
import 'package:flutter/material.dart';

import 'Pages/SettingsPage/account.dart';
import 'Pages/splash_screen.dart';

class Cycle extends StatefulWidget {
  const Cycle({super.key});

  @override
  State<Cycle> createState() => _CycleState();
}

class _CycleState extends State<Cycle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,

      routes: {
        '/SplashScreen' : (context) => const SplashScreen(),
        '/HomePage' : (context) => const HomePage(),
        '/GoogleMapsPage' : (context) => const GoogleMapsPage(),
        '/Settings' : (context) => const SettingPage(),
        '/LoginPage' : (context) => const LoginPage(),
        '/RegisterPage' : (context) => const RegisterPage(),
        '/AccountPage' : (context) => const Account(),
        '/ProfilePhotoEditPage' : (context) => const ProfilePhotoEditPage(),
        '/Statistic' : (context) => const Placeholder(),
      },
      initialRoute: '/HomePage',
    );
  }
}
