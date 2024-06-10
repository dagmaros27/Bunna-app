import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/components/history/history_card.dart';
import 'package:bunnaapp/providers/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.read<HistoryProvider>().history;
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Previous results",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const Divider(
              endIndent: 64,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final result = history[index];
                  return HistoryCard(result: result);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
