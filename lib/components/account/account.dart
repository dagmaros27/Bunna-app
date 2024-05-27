import 'package:bunnaapp/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        body: Column(
          children: [
            Row(
              children: [
                const Text("Name"),
                Text(context.read<UserProvider>().username ?? "")
              ],
            ),
            Row(
              children: [
                const Text("Role"),
                Text(context.read<UserProvider>().role ?? "")
              ],
            ),
            Row(
              children: [
                const Text("Access Token"),
                Text(context.read<UserProvider>().authToken ?? "")
              ],
            )
          ],
        ));
  }
}
