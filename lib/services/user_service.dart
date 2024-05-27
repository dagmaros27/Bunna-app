import 'dart:convert';
import 'dart:developer';
import 'package:bunnaapp/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/user.dart';
import "package:shared_preferences/shared_preferences.dart";

const String backendUrl = 'https://31d8-196-189-55-109.ngrok-free.app/';

Future<void> saveUser(dynamic user) async {}

Future<bool> register(User user) async {
  final url = Uri.parse('$backendUrl/register');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: user.toJsonString(),
  );

  if (response.statusCode == 201) {
    log("user registered successfully");
    return true;
  } else {
    log('Failed to register user: ${response.body}');
    return false;
  }
}

Future<bool> login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  final url = Uri.parse('$backendUrl/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (responseBody != null) {
      final userName = responseBody['firstName'];
      final authToken = responseBody['access_token'];
      final role = responseBody['occupation'];

      // Set the user in the provider
      Provider.of<UserProvider>(context, listen: false).setUser(
        username: userName,
        role: role,
        authToken: authToken,
      );
      return true;
    } else {
      log('Auth token or user info not found in the response');
      return false;
    }
  } else {
    log('Failed to login: ${response.body}');
    return false;
  }
}

Future<bool> forgotPassword(String email) async {
  final url = Uri.parse('$backendUrl/forgot-password');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    log("password reset successful");
    return true;
  } else {
    log('Failed to request password reset: ${response.body}');
    return false;
  }
}

Future<User?> getUser(String email) async {
  final url = Uri.parse('$backendUrl/user?email=$email');
  final response =
      await http.get(url, headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = jsonDecode(response.body);
    return User(
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
      password: userData['password'],
      phoneNumber: userData['phoneNumber'],
      region: userData['region'],
      zone: userData['zone'],
      occupationType: userData['occupationType'],
    );
  } else {
    log('Failed to get user: ${response.body}');
    return null;
  }
}

Future<bool> updateUser(User user) async {
  final url = Uri.parse('$backendUrl/user');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: user.toJsonString(),
  );

  if (response.statusCode == 200) {
    log("updated user");
    return true;
  } else {
    log('Failed to update user: ${response.body}');
    return false;
  }
}
