import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class ProfilePhotoEditPage extends StatefulWidget {
  const ProfilePhotoEditPage({super.key});

  @override
  State<ProfilePhotoEditPage> createState() => _ProfilePhotoEditPageState();
}

class _ProfilePhotoEditPageState extends State<ProfilePhotoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                            Navigator.popAndPushNamed(context, '/AccountPage');
                          },
                          icon: const Icon(Icons.arrow_back_ios_new))),
                  const Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: FluttermojiCustomizer(autosave: false),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    width: 150,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(45))),
                    child: FluttermojiSaveWidget(
                      splashColor: Colors.white,
                        splashFactory: InkRipple.splashFactory,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Changes saved successfully")));
                        },
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
