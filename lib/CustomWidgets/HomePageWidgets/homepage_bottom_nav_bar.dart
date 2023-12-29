import 'package:flutter/material.dart';
@Deprecated("HomePageBottomAppBar better than this class")
class HomePageBottomNavigationBar extends StatefulWidget {
  const HomePageBottomNavigationBar({super.key});

  @override
  State<HomePageBottomNavigationBar> createState() =>
      _HomePageBottomNavigationBarState();
}

class _HomePageBottomNavigationBarState
    extends State<HomePageBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
        unselectedItemColor: Colors.greenAccent,
        fixedColor: Colors.green,
        items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: 'Stats'),
      BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined),label: 'State'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
    ]);
  }
}
