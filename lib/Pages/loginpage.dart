import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: const Color(0xFFf8fdff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
              image: AssetImage("assets/user.png"),
              height: 128,
              width: 128,
              alignment: Alignment.topCenter),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Welcome Again",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(125, 45)),
                    overlayColor: MaterialStatePropertyAll(Colors.greenAccent)),
                onPressed: () {
                  loginUser(emailController.text, passwordController.text);
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Color(0xFF00210b), fontSize: 25),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/RegisterPage');
                    },
                    child: const Text(
                      "New Here? Create Account",
                      style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<int> loginUser(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((value) => Navigator.popAndPushNamed(context, '/AccountPage'));
    } on FirebaseAuthException catch (e) {
      debugPrint("Error:${e.code}");
    }
    return 0;
  }
}
