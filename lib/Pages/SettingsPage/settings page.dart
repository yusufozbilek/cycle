//author:kadirhan yartaşı
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:permission_handler/permission_handler.dart';
import 'about.dart';
import 'help.dart';
import 'language.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var firebaseAuth = FirebaseAuth.instance;
  var reloader = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseAuth.authStateChanges().listen((event) {event!.reload();});
  }
  @override
  Widget build(BuildContext context) {
    if(reloader == true){
      setState(() {

      });
    }
    return Scaffold(
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(alignment: Alignment.centerLeft,child: IconButton(onPressed: (){
                      Navigator.popAndPushNamed(context, '/HomePage');
                    }, icon: const Icon(Icons.arrow_back_ios_new))),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                  ),
                  child: Text(
                    "Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      if(firebaseAuth.currentUser == null){
                        Navigator.popAndPushNamed(context, '/LoginPage').then((value) => reloader = true);
                      }else{
                        Navigator.popAndPushNamed(context, '/AccountPage').then((value) => reloader = true);
                      }

                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: firebaseAuth.currentUser == null ? Image.asset("assets/user.png", scale: 10,) : FluttermojiCircleAvatar(radius: 25,)
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    firebaseAuth.currentUser == null ? "Click to login" : "Logged",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                )),
                          ]),
                          const Icon(
                            Icons.chevron_right_outlined,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Account
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Language()));
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/language.png",
                                  scale: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Language",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                            const Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ],
                        )), //help
                  ),
                ), ////Languege
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      requestPermissionL();
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/pages.png",
                                  scale: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                            const Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ],
                        )), //help
                  ),
                ), //location
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      requestPermissionN();
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/pages.png",
                                  scale: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Notification",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                            const Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ],
                        )), //help
                  ),
                ), //notifications
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Image.asset(
                                      "assets/info.png",
                                      scale: 16,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ]),
                            const Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ],
                        )), //help
                  ),
                ), //about
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Help()));
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/question-mark.png",
                                  scale: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Help",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                            const Icon(
                              Icons.chevron_right_outlined,
                              size: 30,
                            ),
                          ],
                        )), //help
                  ),
                ), //help
              ],
            ),
          ),
        ));
  }

  Future<void> requestPermissionL() async {
    const permission = Permission.location;

    if (await permission.isDenied) {
      var result = await permission.request();
      if (result.isGranted) {
        debugPrint("Granted");
      } else if (result.isDenied) {
        debugPrint("Denied");
      } else if (result.isPermanentlyDenied) {
        debugPrint("PermanentlyDenied");
      }
    }
  }

  Future<void> requestPermissionN() async {
    final permission = Permission.notification;

    if (await permission.isDenied) {
      final result = await permission.request();

      if (result.isGranted) {
        // Permission is granted
      } else if (result.isDenied) {
        // Permission is denied
      } else if (result.isPermanentlyDenied) {
        // Permission is permanently denied
      }
    }
  }
}
