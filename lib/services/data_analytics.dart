import 'package:bunnaapp/models/analytics.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AnalyticsService {
  final String backendurl = 'http://localhost:5000/researcher-page';

  Future<Analytics> fetchAnalyticsData() async {
    final response = await http.get(Uri.parse(backendurl));

    if (response.statusCode == 200) {
      return Analytics.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load analytics data');
    }
  }
}
