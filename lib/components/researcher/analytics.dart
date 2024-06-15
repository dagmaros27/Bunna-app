import 'dart:developer';

import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/components/researcher/bar_graph.dart';
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  // Dummy data for bar charts
  final Map<String, List<List>> barData = {
    "Disease A": [
      [10.0, 20.0, 30.0, 40.0], // Frequencies
      ["Region 1", "Region 2", "Region 3", "Region 4"] // Regions
    ],
    "Disease B": [
      [15.0, 25.0, 35.0, 45.0],
      ["Region 1", "Region 2", "Region 3", "Region 4"]
    ],
    "Disease C": [
      [20.0, 30.0, 40.0, 50.0],
      ["Region 1", "Region 2", "Region 3", "Region 4"]
    ]
  };

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
      endDrawer: UserDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text("Disease distribution per region ",
                        style: TextStyle(fontSize: 24)),
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 231, 230, 230),
                  indent: 16,
                  endIndent: 16,
                ),
                if (barData != null)
                  ...barData.entries.map((entry) {
                    String disease = entry.key;
                    List<int> frequencies = entry.value[0].cast<int>();
                    List<String> regions = entry.value[1].cast<String>();
                    log("$disease ${frequencies.length}");
                    return _buildBarChartSample(
                      frequencies: frequencies,
                      regions: regions,
                      barColor: Colors.blue,
                      title: disease,
                    );
                  }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarChartSample({
    required List<int> frequencies,
    required List<String> regions,
    required Color barColor,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 223, 222, 222)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32, // Adjust width as needed
        child: DiseaseChart(
          frequencies: frequencies,
          regions: regions,
          barColor: barColor,
          diseaseName: title,
        ),
      ),
    );
  }
}
