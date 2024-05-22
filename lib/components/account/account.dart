import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

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
        body: const Center(
            child: Text("To be developed",
                style: TextStyle(color: Colors.grey, fontSize: 36))));
  }
}
