import 'package:cycle/Bloc/HomePage_cubits/homepage_bottom_app_bar_navigation_cubit.dart';
import 'package:cycle/Bloc/HomePage_cubits/homepage_homescreen_firestore_cubit.dart';
import 'package:cycle/CustomWidgets/HomePageWidgets/homepage_body.dart';
import 'package:cycle/CustomWidgets/HomePageWidgets/homepage_bottom_app_bar.dart';
import 'package:cycle/CustomWidgets/HomePageWidgets/homepage_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomePageBottomAppBarNavigationCubit()),
        /*BlocProvider(create: (context) => HomePageFirebaseCubit())*/
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          extendBody: false,
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          appBar: const HomePageTopAppBar(),
          floatingActionButton: BlocBuilder<HomePageBottomAppBarNavigationCubit,String>(
            builder: (context,pageName) {
              return FloatingActionButton(
                  onPressed: () {
                    context
                        .read<HomePageBottomAppBarNavigationCubit>()
                        .changeCurrentPage("GoogleMaps");
                  },
                  child: const Icon(
                    Icons.recycling,
                    color: Colors.white,
                  ));
            }
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: const HomePageBody(),
          bottomNavigationBar: const HomePageBottomAppBar()),
    );
  }
}
