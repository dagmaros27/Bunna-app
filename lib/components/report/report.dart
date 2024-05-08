import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    String? reportSubject;
    final reportTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "CODICAP",
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "If there is an issue withe the application you want to report, just send us a message"),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              hintText: "Subject",
              initialSelection: 'App not working',
              onSelected: (String? newValue) {
                setState(() {
                  reportSubject = newValue;
                });
              },
              dropdownMenuEntries: <String>[
                'App not working',
                'Result is inconsistent',
                'Result not shown',
                'Network error',
                'Other issue'
              ].map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: (value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: TextField(
                  minLines: 4,
                  maxLines: 8,
                  controller: reportTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Issue to be reported",
                  )),
            ),
            const SizedBox(height: 16),
            TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Submit"),
                )),
          ],
        ),
      ),
    );
  }
}
