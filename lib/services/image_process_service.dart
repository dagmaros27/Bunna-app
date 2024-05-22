import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import "../models/disease_info.dart";
import "../models/report.dart";

const String backendUrl = 'https://ffa0-196-190-60-218.ngrok-free.app/';

Future<Map<String, dynamic>?> processImage(File imageFile) async {
  final url = Uri.parse('$backendUrl/coffee-disease-detection');
  final prefs = await SharedPreferences.getInstance();

  final String? authToken = prefs.getString('auth-token');

  if (authToken == null) {
    log('Auth token not found');
    return null;
  }

  var request = http.MultipartRequest('POST', url);
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  request.headers['Authorization'] = 'Bearer $authToken';

  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);

      var report = Report.fromJson(jsonResponse);
      var diseaseInfo = DiseaseInfo.fromJson(jsonResponse);

      log("Report: $report");
      log("Disease Info: $diseaseInfo");
      return {
        'report': report,
        'diseaseInfo': diseaseInfo,
      };
    } else {
      var responseBody = await response.stream.bytesToString();
      log('Failed to process image: $responseBody');
      return null;
    }
  } catch (e) {
    log('Exception while processing image: $e');
    return null;
  }
}
