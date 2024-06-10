import 'dart:convert';
import 'dart:developer';
import 'package:bunnaapp/models/analytics.dart';
import 'package:bunnaapp/providers/analytics_provider.dart';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/urls.dart';

String backendUrl = GlobalUrl.rootUrl;

Future<bool> fetchAnalyticsData(BuildContext context) async {
  final String? authToken = context.read<UserProvider>().authToken;

  if (authToken == null) {
    log('Auth token not found');
    throw Exception('Auth token not found');
  }

  final url = Uri.parse('$backendUrl/researcher-page');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final List<Disease> countByDisease =
          (jsonResponse['Count by disease'] as List)
              .map((i) => Disease.fromJson(i))
              .toList();

      final List<Region> countByRegion =
          (jsonResponse['Count by region'] as List)
              .map((i) => Region.fromJson(i))
              .toList();

      final Map<String, dynamic> prevalencyJson =
          jsonResponse['prevalency per region'];
      final Map<String, List<DiseasePrevalency>> prevalencyMap = {};

      prevalencyJson.forEach((key, value) {
        final List<dynamic> diseasePrevalencyList = value;
        final List<DiseasePrevalency> diseasePrevalency = [];

        diseasePrevalencyList.forEach((element) {
          final String count =
              element['count'].toString(); // Convert int to string
          final String region = element['region'];

          diseasePrevalency.add(DiseasePrevalency(
            disease: key,
            count: count,
            region: region,
          ));
        });

        prevalencyMap[key] = diseasePrevalency;
      });

      final analytics = Analytics(
        totalDiseaseReport: jsonResponse['Total disease Report'],
        countByDisease: countByDisease,
        countByRegion: countByRegion,
        prevalency: prevalencyMap,
      );

      context.read<AnalyticsProvider>().setResult(analytics);
      return true;
    } else {
      log('Failed to load analytics data: ${response.body}');
      throw Exception('Failed to load analytics data');
    }
  } catch (e) {
    // Handle network error
    log('Network error: $e');
    throw Exception('Network error occurred');
  }
}
