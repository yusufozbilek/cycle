import 'package:flutter/material.dart';

class HomePageTopAppBar extends StatefulWidget implements PreferredSizeWidget{
  const HomePageTopAppBar({super.key});

  @override
  State<HomePageTopAppBar> createState() => _HomePageTopAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomePageTopAppBarState extends State<HomePageTopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Home",style: TextStyle(color:Colors.white,fontSize: 28),),
      backgroundColor: Colors.greenAccent,/*TODO change Color*/
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: Colors.white)),
        IconButton(onPressed: (){Navigator.pushNamed(context, '/Settings');}, icon: const Icon(Icons.settings, color: Colors.white)),
      ],
    );
  }


}
