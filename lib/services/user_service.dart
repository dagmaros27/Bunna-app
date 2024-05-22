import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import "package:shared_preferences/shared_preferences.dart";

const String backendUrl = 'https://ffa0-196-190-60-218.ngrok-free.app/';

Future<void> saveAuthToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth-token', token);
}

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

login({required String email, required String password}) async {
  final url = Uri.parse('$backendUrl/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    final authToken = responseBody['access_token'];

    if (authToken != null) {
      await saveAuthToken(authToken);
      log('Auth token saved: $authToken');
      return true;
    } else {
      log('Auth token not found in the response');
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
