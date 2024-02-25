//author kadir han yartaşı
import 'package:flutter/material.dart';

import 'settings page.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 88, 66, 1.000),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
             GestureDetector(
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingPage()));
      },

               child: const Padding(
                 padding: EdgeInsets.only(top: 20),
                 child: Icon(
                      Icons.chevron_left_outlined,
                      size: 30,
                    ),
               ), ),
                ],
              ),
              Column(
                children:[ Image.asset("assets/resting.gif"),
                  const Text("In development feature",style: TextStyle(height: 5,fontSize:30),),


              ])
            ],
          ),
        )


      ),

    );
  }
}

