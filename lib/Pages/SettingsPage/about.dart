import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';

//author kadir han yartaşı
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String aboutText = "";
  @override
  void initState() {
    super.initState();
    _loadAboutText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/HomePage');
                          },
                          icon: const Icon(Icons.arrow_back_ios_new))),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(child: Markdown(data: aboutText, styleSheet: MarkdownStyleSheet(
                h1: const TextStyle(
                    color: Colors.black,
                    fontSize: 36),
                h2: const TextStyle(
                    color: Colors.black,
                    fontSize: 28),
                h3: const TextStyle(
                    color: Colors.black,
                    fontSize: 24),
                h4: const TextStyle(
                    color: Colors.black,
                    fontSize: 20),
                p: const TextStyle(
                    color: Colors.black,
                    fontSize: 18),
                em: const TextStyle(
                    color: Colors.black),
                a: const TextStyle(
                    color: Colors.black),
                blockquote: const TextStyle(
                    color: Colors.black),
                del: const TextStyle(
                    color: Colors.black),
                strong: const TextStyle(
                    color: Colors.black),
                tableBody: const TextStyle(
                    color: Colors.black),
                tableHead: const TextStyle(
                    color: Colors.black),
                listBullet: const TextStyle(
                    color: Colors.black,
                    fontSize: 18),
              ),))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadAboutText() async {
    String aboutTextContent;

    try {
      aboutTextContent = await rootBundle.loadString('assets/texts/about.md');
    } catch (e) {
      aboutTextContent = 'File reading error: $e';
    }

    if (mounted) {
      setState(() {
        aboutText = aboutTextContent;
      });
    }
  }
}
