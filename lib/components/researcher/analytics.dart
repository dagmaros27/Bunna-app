import 'package:flutter/material.dart';
import 'package:bunnaapp/components/researcher/bar_graph.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
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
      body: ListView(
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
          _buildBarChartSample(
              frequencies: const [12, 34, 25, 17, 22],
              regions: const ["harar", "gurage", "oromiya", "gambella", "afar"],
              barColor: Colors.green,
              title: "Disease 1"),
          _buildBarChartSample(
              frequencies: const [12, 34, 25, 17, 22],
              regions: const ["harar", "gurage", "oromiya", "gambella", "afar"],
              barColor: Colors.yellow,
              title: "Disease 2"),
          _buildBarChartSample(
              frequencies: const [12, 34, 25, 17, 22],
              regions: const ["harar", "gurage", "oromiya", "gambella", "afar"],
              barColor: Colors.red,
              title: "Disease 3"),
          _buildBarChartSample(
              frequencies: const [12, 34, 25, 17, 22],
              regions: const ["harar", "gurage", "oromiya", "gambella", "afar"],
              barColor: Colors.blue,
              title: "Disease 4"),
        ],
      ),
    );
  }

  Widget _buildBarChartSample(
      {required List<int> frequencies,
      required List<String> regions,
      required Color barColor,
      required String title}) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 223, 222, 222)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DiseaseChart(
        frequencies: frequencies,
        regions: regions,
        barColor: barColor,
        diseaseName: title,
      ),
    );
  }
}
