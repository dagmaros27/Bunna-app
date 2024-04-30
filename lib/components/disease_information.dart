import 'package:flutter/material.dart';
import '../models/disease_info.dart';

class DiseaseInformation extends StatelessWidget {
  const DiseaseInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 4, 92, 25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Diagnosis", style: Theme.of(context).textTheme.displaySmall),
            const Divider(
              color: Color(0xFFD3D1D1),
              thickness: 0.7,
            ),
            Text(DiseaseInfo.dummyInfo.diagnosis),
            const SizedBox(height: 16),
            Text("Recommended Actions",
                style: Theme.of(context).textTheme.displaySmall),
            const Divider(
              color: Color(0xFFD3D1D1),
              thickness: 0.7,
            ),
            ...DiseaseInfo.dummyInfo.recommendations
                .map((recommendation) => Text(recommendation)),
            const SizedBox(height: 16),
            Text("Additional Information",
                style: Theme.of(context).textTheme.displaySmall),
            const Divider(
              color: Color(0xFFD3D1D1),
              thickness: 0.7,
            ),
            ...DiseaseInfo.dummyInfo.additional.map((info) => Text(info)),
          ],
        ),
      ),
    );
  }
}
