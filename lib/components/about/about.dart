import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Us",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 10),
            Text(
              "CODICAP is a coffee disease classifier application. Users can send the image of a coffee leaf or bean and get a result of the diagnosis and information about the disease found, if any.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Text(
              "Address:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Addis Ababa University",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Text(
              "App developed by:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "dagmaros27",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
