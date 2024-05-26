import 'dart:io';
import 'package:bunnaapp/components/account/account.dart';
import 'package:bunnaapp/components/auth/auth.dart';
import 'package:bunnaapp/components/information/informations.dart';
import 'package:bunnaapp/components/signin/sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../report/report.dart';
import "package:flutter/material.dart";
import '../imageProcessing/image_processing.dart';
import '../../themes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? pickedImage;
  final auth = AuthService();

  //function to
  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(returnedImage.path);
    });

    _gotoProcessing();
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(returnedImage.path);
    });

    _gotoProcessing();
  }

  _gotoProcessing() {
    if (pickedImage != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ImageProcessing(imageFile: pickedImage!)),
      );
    }
  }

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
      drawer: Drawer(
        backgroundColor: const Color(0xE4E9FFE9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(131, 40, 124, 61),
              ),
              child: Text(
                'Coffee Disease Classifier Application (CODICAP)',
              ),
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Account()),
                );
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 200,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.camera_alt, size: 24),
                        Text(
                          "Direct Scan",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 200,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.image, size: 24),
                        Text(
                          "Upload Image",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 200,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Informations()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.info, size: 24),
                        Text(
                          "Informations",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 200,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Report()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.report_problem, size: 24),
                        Text(
                          "Report Issues",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
