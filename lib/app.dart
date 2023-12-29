import 'package:cycle/Pages/googlemapspage.dart';
import 'package:cycle/Pages/homepage.dart';
import 'package:flutter/material.dart';

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
      routes: {
        '/SplashScreen' : (context) => const SplashScreen(),
        '/HomePage' : (context) => const HomePage(),
        '/GoogleMapsPage' : (context) => const GoogleMapsPage(),
        '/Recycle' : (context) => const Placeholder(),
        '/Statistic' : (context) => const Placeholder(),
        '/Recycle/Paper' : (context) => const Placeholder(),
        '/Recycle/Plastic' : (context) => const Placeholder(),
        '/Recycle/Metal' : (context) => const Placeholder(),
        '/Recycle/Organic' : (context) => const Placeholder(),
        '/Recycle/Battery' : (context) => const Placeholder(),
        '/Recycle/Electronic' : (context) => const Placeholder(),
        '/Recycle/Textile' : (context) => const Placeholder(),
        '/Recycle/Rubber' : (context) => const Placeholder()
      },
      initialRoute: '/HomePage',
    );
  }
}
