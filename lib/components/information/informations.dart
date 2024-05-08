import 'package:flutter/material.dart';

class Informations extends StatelessWidget {
  const Informations({super.key});

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
        body: const Center(child: Text("No new Information Available")));
  }
}
