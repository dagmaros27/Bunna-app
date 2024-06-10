import 'dart:developer';

import 'package:bunnaapp/components/drawer/user_drawer.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:flutter/material.dart';
import 'package:bunnaapp/components/researcher/bar_graph.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    final analyticsProvider = context.read<AnalyticsProvider>().analytics;
    final barData = analyticsProvider?.getBarData();
    log("$barData");
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
