import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          )),
        ),
        body: const Center(child: Text("No history")));
  }
}
