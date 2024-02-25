import 'package:flutter/material.dart';

import 'SettingsPage/settings page.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/work.gif"),
              const Text("We are working on it",style: TextStyle(height: 5,fontSize:30),)
          ],
        ),
      ),
    );
  }
}
