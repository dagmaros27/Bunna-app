import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bunnaapp/models/models.dart';
import 'package:bunnaapp/providers/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/disease_info.dart';
import '../models/report.dart';
import '../providers/user_providers.dart';

const String backendUrl = 'https://31d8-196-189-55-109.ngrok-free.app/';

Future<Map<String, dynamic>?> processImage(
    File imageFile, BuildContext context) async {
  final url = Uri.parse('$backendUrl/coffee-disease-detection');

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String? authToken = userProvider.authToken;

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

      Provider.of<ResultProvider>(context, listen: false)
          .setResult(Result(diseaseInfo: diseaseInfo, report: report));
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
