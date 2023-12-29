import 'package:cycle/Bloc/HomePage_cubits/homepage_bottom_app_bar_navigation_cubit.dart';
import 'package:cycle/CustomWidgets/HomePageWidgets/homepage_bottom_nav_bar.dart';
import 'package:cycle/CustomWidgets/HomePageWidgets/homepage_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBody extends StatefulWidget {

  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomePageBottomAppBarNavigationCubit, String>(
        builder: (context, homepageRoute) {
          if (homepageRoute == 'Home') {
            return const HomeScreen();
          }else {
            return const Text("Stats");
          }
        },
      );
}