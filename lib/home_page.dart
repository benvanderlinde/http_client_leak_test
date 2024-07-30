import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  int totalNumberOfConnections = 0;
  int currentNumberOfconnections = 0;
  bool inputEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
                labelText: "Number of connections to create: "),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            enabled: inputEnabled,
          ),
        ),
        FilledButton(
            onPressed: () async {
              runTest();
            },
            child: Text("Run Test")),
        if (currentNumberOfconnections > 0) ...[
          Text(currentNumberOfconnections.toString()),
        ],
      ]),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void runTest() {
    setState(() {
      inputEnabled = false;
    });

    int numberOfTests = int.parse(textController.text);
    totalNumberOfConnections = numberOfTests;
    currentNumberOfconnections = 0;
    for (int i = 0; i < numberOfTests; ++i) {
      setState(() {
        ++currentNumberOfconnections;
      });
      sleep(const Duration(milliseconds: 100));

      http.Client client = http.Client();
      client.get(Uri.parse("https://www.google.com.au"));
      print("Curent number of connections $currentNumberOfconnections");
    }

    setState(() {
      inputEnabled = true;
    });
  }
}
