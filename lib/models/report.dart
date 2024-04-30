class Report {
  String status;
  String timeStamp;
  String diseases;
  String location;
  String severity;
  double confidenceLevel;

  Report(
      {required this.status,
      required this.timeStamp,
      required this.diseases,
      required this.location,
      required this.severity,
      required this.confidenceLevel});

  static Report dummyReport = Report(
      confidenceLevel: 97.7,
      timeStamp: "January 13, 2024, 10:45 AM",
      diseases: " Coffee Rust",
      location: "Lat 10.1234, Lon -75.5678",
      severity: "moderate",
      status: "Completed");
}
