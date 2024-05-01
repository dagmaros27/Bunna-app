import 'package:flutter/material.dart';
import "../../models/report.dart";

class AnalysisSummary extends StatelessWidget {
  const AnalysisSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 4, 92, 25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                  child: Text("Image Analysis Summary",
                      style: Theme.of(context).textTheme.displayMedium)),
            ),
            const Divider(
              color: Color(0xFFD3D1D1),
              thickness: 0.7,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Status: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text(
                              Report.dummyReport.status,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Image Timestamp: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text(Report.dummyReport.timeStamp),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Location: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text(Report.dummyReport.location),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Disease Identified: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text(Report.dummyReport.diseases),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Severity: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text(Report.dummyReport.severity),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Confidence Level: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            const SizedBox(width: 10),
                            Text("${Report.dummyReport.confidenceLevel}%"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
