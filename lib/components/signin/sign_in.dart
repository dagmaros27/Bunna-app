import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '/components/auth/auth.dart';
import '../home/home.dart';
import '/components/signup/page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_service.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final auth = AuthService();

    goToHome(BuildContext context) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    }

    _login(BuildContext context) async {
      String email = emailController.text.trim();
      String password = passwordController.text;
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      bool validEmail = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (email == "" || password == "" || !validEmail) {
        log("invalid email or password");
        const snackBar = SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Color.fromRGBO(255, 14, 22, 0.671),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // final user = await auth.logInUserWithEmailAndPassword(
        //     email: email, password: password);

        final loggedIn = await login(email: email, password: password);

        if (loggedIn == true) {
          goToHome(context);
        } else {
          const snackBar = SnackBar(content: Text('Logging failed'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Sign In",
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "john@example.com"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextButton(
                    onPressed: () {
                      _login(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Center(child: Text("Log In")),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Color(0xFFD3D1D1),
                    thickness: 0.7,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet? "),
                    GestureDetector(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color(0xFF00B115)),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                          (route) => false,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
