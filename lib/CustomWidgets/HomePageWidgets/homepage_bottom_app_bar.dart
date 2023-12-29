import 'package:cycle/Bloc/HomePage_cubits/homepage_bottom_app_bar_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBottomAppBar extends StatelessWidget {
  const HomePageBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.green,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){context.read<HomePageBottomAppBarNavigationCubit>().changeCurrentPage("Home");},icon: const Icon(Icons.home,color: Colors.white,)),
            IconButton(onPressed: (){context.read<HomePageBottomAppBarNavigationCubit>().changeCurrentPage("Stats");},icon: const Icon(Icons.bar_chart,color: Colors.white,)),
          ],
        ),
      ),
    );
  }
}
