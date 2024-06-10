import "dart:developer";

import "package:bunnaapp/components/about/about.dart";
import "package:bunnaapp/components/account/account.dart";
import "package:bunnaapp/components/drawer/user_drawer.dart";
import "package:bunnaapp/components/history/history.dart";
import "package:bunnaapp/components/researcher/analytics.dart";
import "package:bunnaapp/components/researcher/bar_graph.dart";
import "package:bunnaapp/components/signin/sign_in.dart";
import "package:bunnaapp/providers/analytics_provider.dart";
import "package:bunnaapp/services/analytics_service.dart";
import "package:countup/countup.dart";
import "package:provider/provider.dart";

import "piechart.dart";
import "package:flutter/material.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final analyticsProvider = context.read<AnalyticsProvider>().analytics;
    final pieData = analyticsProvider?.getPiechartData();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      drawer: UserDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  color: const Color(0xEBD6FFE0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Total samples analyzed",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Countup(
                            begin: 0,
                            end: analyticsProvider?.totalDiseaseReport
                                    .toDouble() ??
                                0.0,
                            suffix: "+images",
                            duration: const Duration(seconds: 3),
                            separator: ',',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "This metric shows the total number of coffee leaf samples that have been analyzed using the CODICAP system.",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: const Color(0xEBD6FFE0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Accuracy rate",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Countup(
                              begin: 0,
                              end: 83.47,
                              duration: const Duration(seconds: 3),
                              separator: ',',
                              suffix: "%",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 36,
                              ),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "The accuracy rate indicates how correctly the system identifies diseases in the analyzed samples",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Color(0xEBD6FFE0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        child: Text(
                          "Results from analysis",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      PieChartSample2(
                        diseaseNames: pieData[0],
                        percentages: pieData[1],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "The pie chart provides a visual representation of the different types of diseases detected in the analyzed samples",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24.0, bottom: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          "For detailed distribution analytics",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Analytics()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Details"),
                              Icon(Icons.analytics_outlined)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
