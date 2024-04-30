import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'results.dart';

class ProcessingCard extends StatelessWidget {
  const ProcessingCard({Key? key});

  @override
  Widget build(BuildContext context) {
    String status = "processing";
    int remainingMinutes = 12;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 56, bottom: 16, right: 16),
          child: LinearPercentIndicator(
            width: 380,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2000,
            percent: 0.9,
            center: const Text("Processing image(90.0%)"),
            barRadius: const Radius.circular(12),
            progressColor: Colors.green.shade800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 72,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: $status"),
              Text("Remaining Time: $remainingMinutes min")
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: add functionality to show result once the processing finished
                  //disable the button unless
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Results()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(120, 50),
                ),
                child: const Center(child: Text("Result")),
              ),
              TextButton(
                onPressed: () {
                  //TODO: add functionality to stop the processing
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(120, 50),
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white),
                child: const Center(
                  child: Text(
                    "Cancel",
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
