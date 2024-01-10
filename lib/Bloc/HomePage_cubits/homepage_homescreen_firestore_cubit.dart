import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
/*
class HomePageFirebaseCubit extends Cubit<void> {
  HomePageFirebaseCubit() : super(FirebaseFirestore.instance.collection("hel"));
  Future<void> getContents(String id) async {
    var document = await FirebaseFirestore.instance
        .collection("HomePageCategories")
        .doc(id)
        .collection("Contents")
        .orderBy("Title")
        .get()
        .then((value) => print("###################### ${value.docs[0].id}) ###############"));
  }
}*/
