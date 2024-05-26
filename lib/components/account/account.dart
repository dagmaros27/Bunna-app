import 'package:bunnaapp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text("Name: "),
                Text(context.watch<UserProvider>().username ?? "")
              ],
            ),
            Row(
              children: [
                const Text("Token: "),
                Text(context.watch<UserProvider>().authToken ?? "")
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      context.read<UserProvider>().clearUser();
                    },
                    child: const Text("clear"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
