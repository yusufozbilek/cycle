import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle/Bloc/HomePage_cubits/homepage_homescreen_firestore_cubit.dart';
import 'package:cycle/CustomWidgets/custom_overscroll_behavior.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<HomePageFirebaseCubit>().getContents("fPsJukh87gzqUlfj9B2o");
    return ScrollConfiguration(
      behavior: CustomOverscrollBehavior(),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: FirestoreListView(
              query:
                  FirebaseFirestore.instance.collection("HomePageCategories"),
              errorBuilder: (context, error, stackTrace) =>
                  Text(stackTrace.toString()),
              itemBuilder: (context, doc) {
                var id = doc.id;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(doc['Title']),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
