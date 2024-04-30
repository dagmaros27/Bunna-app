import "package:bunnaapp/components/results.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:bunnaapp/components/signin/sign_in.dart";
import "package:bunnaapp/firebase_options.dart";
import "components/home.dart";
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Bunna());
}

class Bunna extends StatelessWidget {
  const Bunna({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.light();
    return MaterialApp(
      //coffee disease classifier application
      debugShowCheckedModeBanner: false,
      title: "CODICAP",
      home: const Results(),
      theme: theme,
    );
  }
}
