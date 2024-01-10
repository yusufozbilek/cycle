import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle/Entity/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fdff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Welcome",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Username", style: TextStyle(fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Email", style: TextStyle(fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: TextStyle(fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Password Confirm", style: TextStyle(fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: TextField(
              controller: passwordConfirmController,
              decoration: const InputDecoration(
                  hintText: 'Password Confirm',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(125, 45)),
                    overlayColor: MaterialStatePropertyAll(Colors.greenAccent)),
                onPressed: () {
                  signUp(usernameController.text, emailController.text,
                      passwordController.text, passwordConfirmController.text);
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Color(0xFF00210b), fontSize: 25),
                )),
          ),
        ],
      ),
    );
  }

  Future<int> signUp(String username, String email, String password,
      String passwordConfirm) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (password != passwordConfirm) {
      return 0;
    } else {
      try {
        firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          /*TODO add User firebase firestore creation*/
          final user = firebaseUser(
              userID: value.user!.uid,
              username: username,
              email: email,
              creationDate: DateTime.now());
          DocumentReference reference =
              firebaseFirestore.collection("Users").doc(user.userID);
          await reference.set({
            'Uid': user.userID,
            "Email": user.email,
            "Username": user.username,
            "CreationDate": user.creationDate
          }).then(
              (value) => Navigator.popAndPushNamed(context, "/AccountPage"));
        });
      } on FirebaseAuthException catch (firebaseAuthException) {
        debugPrint(firebaseAuthException.stackTrace.toString());
      }
    }
    return 0;
  }
}
