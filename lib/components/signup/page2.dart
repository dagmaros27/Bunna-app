import 'dart:developer';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import '/components/auth/auth.dart';
import '../home/home.dart';
import '../../models/user.dart';
import "page1.dart";

class SignUp2 extends StatelessWidget {
  final User user;

  const SignUp2({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CODICAP",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Page2(user: user),
    );
  }
}

class Page2 extends StatefulWidget {
  final User user;

  Page2({Key? key, required this.user}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String? regionValue;
  String? zoneValue;
  String? occupationValue;

  final TextEditingController phoneController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    _goToHome() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Home()));
    }

    signup(user) async {
      if (user.isValid()) {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);

        if (newUser != null) {
          log("User created successfully");
          _goToHome();
        }
      } else {
        const snackBar = SnackBar(content: Text('Missing or Invalid input'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Center(
          child: SizedBox(
            width: 350,
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back, size: 24),
                          Text("Back"),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Phone Number",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CountryFlag.fromCountryCode(
                          'et',
                          height: 30,
                          width: 30,
                          borderRadius: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: DropdownMenu<String>(
                        hintText: "Region",
                        onSelected: (String? newValue) {
                          setState(() {
                            regionValue = newValue;
                          });
                        },
                        dropdownMenuEntries: <String>[
                          'Gurage',
                          'Guji',
                          'Gonder',
                          'Gojam',
                          'Arsi'
                        ].map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                            value: value,
                            label: (value),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: DropdownMenu<String>(
                        hintText: "Zone",
                        onSelected: (String? newValue) {
                          setState(() {
                            zoneValue = newValue;
                          });
                        },
                        dropdownMenuEntries: <String>[
                          'Gurage',
                          'Guji',
                          'Gonder',
                          'Gojam',
                          'Arsi'
                        ].map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                            value: value,
                            label: (value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownMenu<String>(
                    hintText: "Occupation",
                    onSelected: (String? newValue) {
                      setState(() {
                        occupationValue = newValue;
                      });
                    },
                    dropdownMenuEntries: <String>['Farmer', 'Researcher']
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: (value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.user.phoneNumber = phoneController.text;
                      widget.user.region = regionValue;
                      widget.user.zone = zoneValue;
                      widget.user.occupationType = occupationValue;

                      signup(widget.user);
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text("Register"))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
