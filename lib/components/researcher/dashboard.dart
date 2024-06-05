import "package:bunnaapp/components/about/about.dart";
import "package:bunnaapp/components/account/account.dart";
import "package:bunnaapp/components/history/history.dart";
import "package:bunnaapp/components/researcher/analytics.dart";
import "package:bunnaapp/components/researcher/bar_graph.dart";
import "package:bunnaapp/components/signin/sign_in.dart";

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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xE4E9FFE9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(131, 40, 124, 61),
              ),
              child: Text(
                'Coffee Disease Classifier Application (CODICAP)',
              ),
            ),
            ListTile(
              title: const Text('Detailed Analytics'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Analytics()),
                );
              },
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Account()),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Total samples analyzed ",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "300+",
                            style: TextStyle(
                              fontSize: 48,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Accuracy rate ",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "85.6%",
                            style: TextStyle(
                              fontSize: 48,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 16),
                        child: Text(
                          "Results from analysis ",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      PieChartSample2(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
