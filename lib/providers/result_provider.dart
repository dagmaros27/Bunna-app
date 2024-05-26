import 'package:flutter/material.dart';
import '../models/models.dart';

class ResultProvider with ChangeNotifier {
  Result? _result;

  ResultProvider() {
    // Initialize with dummy data
    _initializeDummyData();
  }

  Result? get result => _result;

  void setResult(Result result) {
    _result = result;
    notifyListeners();
  }

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  void _initializeDummyData() {
    final dummyReport = Report(
      status: 'Completed',
      timeStamp: '2024-05-01 10:00:00',
      diseases: 'Disease A, Disease B',
      location: 'Location X',
      severity: 'High',
      confidenceLevel: 0.95,
    );

    final dummyDiseaseInfo = DiseaseInfo(
      diagnosis: 'Diagnosis A',
      recommendations: 'Recommendation A1, Recommendation A2',
      additional: 'Additional Info A',
    );

    _result = Result(report: dummyReport, diseaseInfo: dummyDiseaseInfo);

    notifyListeners();
  }
}
