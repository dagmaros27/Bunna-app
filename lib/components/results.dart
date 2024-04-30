import "package:flutter/material.dart";
import "analysis_summary.dart";
import "disease_information.dart";

class Results extends StatelessWidget {
  const Results({super.key});

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
        body: ListView(children: const [
          AnalysisSummary(),
          DiseaseInformation(),
        ]));
  }
}
