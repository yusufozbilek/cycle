import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Help extends StatefulWidget {
  const Help({super.key});
 //author:Kadir Han Yartaşı
  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String helpText = "";
  @override
  void initState() {
    super.initState();
    _loadHelpText();
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
              Expanded(child: Markdown(data: helpText, styleSheet: MarkdownStyleSheet(
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

  Future<void> _loadHelpText() async {
    String helpTextContent;

    try {
      helpTextContent = await rootBundle.loadString('assets/texts/help.md');
    } catch (e) {
      helpTextContent = 'File reading error: $e';
    }

    if (mounted) {
      setState(() {
        helpText = helpTextContent;
      });
    }
  }
}
