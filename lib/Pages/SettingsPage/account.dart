import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String username = "";
  String email = "";
  String creationDate = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var currentUser = firebaseAuth.currentUser;
    firebaseFirestore
        .collection("Users")
        .where('Uid', isEqualTo: currentUser!.uid)
        .snapshots()
        .listen((snapshots) {
      var doc = snapshots.docs.first;
      var date = (doc.get("CreationDate") as Timestamp).toDate();
      username = doc.get("Username");
      email = doc.get("Email");
      creationDate = DateFormat('dd-MM-yyyy HH:mm')
          .format(date).toString();
      debugPrint(snapshots.docs.first.id.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fdff),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/Settings');
                        },
                        icon: const Icon(Icons.arrow_back_ios_new))),
                const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                FluttermojiCircleAvatar(
                    radius: 100, backgroundColor: Colors.blueAccent),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ProfilePhotoEditPage');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                username,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 30),
                          ))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(email,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 20)))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Creation Date",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 30),
                          ))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(creationDate,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 20)))),
                ],
              ),
            ),
            /*const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(color: Colors.grey, thickness: 2),
            ),*/
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Account"),
                              content: const Text(
                                  "Are you sure you want to permanently delete your account?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      deleteAccount(firebaseAuth.currentUser!.uid);
                                      Navigator.popAndPushNamed(context, '/HomePage');
                                    },
                                    child: const Text("Delete"))
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: TextButton(
                    onPressed: () {
                      signOut();
                    },
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .signOut()
        .then((value) => Navigator.popAndPushNamed(context, '/Settings'));
  }

  Future<void> deleteAccount(String uid) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      await firebaseFirestore
          .collection("Users")
          .where("Uid", isEqualTo: firebaseAuth.currentUser!.uid)
          .get()
          .then((snapshot) {
        snapshot.docs.first.reference.delete();
        firebaseAuth.currentUser!.delete();
      });
    } on FirebaseAuthException catch (e) {
      debugPrint("Something went wrong");
    }
  }
}
