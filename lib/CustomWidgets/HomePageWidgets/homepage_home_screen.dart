import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle/CustomWidgets/custom_overscroll_behavior.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //context.read<HomePageFirebaseCubit>().getContents("fPsJukh87gzqUlfj9B2o");
    return ScrollConfiguration(
      behavior: CustomOverscrollBehavior(),
      child:
          FirestoreListView(
              query: FirebaseFirestore.instance
                  .collection("HomePageCategories")
                  .orderBy("Date"),
              errorBuilder: (context, error, stackTrace) =>
                  Text(stackTrace.toString()),
              itemBuilder: (context, doc) {
                //var id = doc.id;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Card(
                        color: Colors.greenAccent,
                        child: InkWell(
                          splashColor: Colors.white38,
                          onTap: () async {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              barrierColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                  width: double.maxFinite,
                                  decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25),
                                          topLeft: Radius.circular(25))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 100,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: FutureBuilder(
                                            future: getData(
                                                doc.get("MarkdownText")),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text("Something Went Wrong",style: TextStyle(color: Colors.white,fontSize: 28),);
                                              }
                                              if (snapshot.hasData) {
                                                return Markdown(
                                                  data: snapshot.requireData,
                                                  styleSheet:
                                                      MarkdownStyleSheet(
                                                    h1: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 36),
                                                    h2: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 28),
                                                    h3: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24),
                                                    h4: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                    p: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                    em: const TextStyle(
                                                        color: Colors.white),
                                                    a: const TextStyle(
                                                        color: Colors.white),
                                                    blockquote: const TextStyle(
                                                        color: Colors.white),
                                                    del: const TextStyle(
                                                        color: Colors.white),
                                                    strong: const TextStyle(
                                                        color: Colors.white),
                                                    tableBody: const TextStyle(
                                                        color: Colors.white),
                                                    tableHead: const TextStyle(
                                                        color: Colors.white),
                                                    listBullet: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                );
                                              } else {
                                                return const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Loading",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28
                                                      ),
                                                    ),
                                                    CircularProgressIndicator(color: Colors.white,strokeWidth: 4,strokeAlign: 0.2,)
                                                  ],
                                                );
                                              }
                                            },
                                          )),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${doc.get("Title")}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 28),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${doc.get("Summary")}",
                                          maxLines: 5,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }

  Future<String> getMarkdownContent(String filePath) async {
    Reference reference = FirebaseStorage.instance.ref().child(filePath);
    try {
      String content = await reference.getData() as String;
      return content;
    } catch (e) {
      debugPrint("Error: $e");
      return "";
    }
  }

  Future<String> getData(String fileName) async {
    String fileContent = await FirebaseStorage.instance
        .ref()
        .child("/Markdowns/$fileName")
        .getData()
        .then((data) {
      return utf8.decode(data as Uint8List);
    });
    return fileContent;
  }
}
