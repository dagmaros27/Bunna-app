import "package:bunnaapp/components/home/home.dart";
import "package:bunnaapp/provider/user_provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:bunnaapp/components/signin/sign_in.dart";
import "package:bunnaapp/firebase_options.dart";
import 'themes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const Bunna(),
    ),
  );
}

// void main() {
//   runApp(const Bunna());
// }

class Bunna extends StatelessWidget {
  const Bunna({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.light();
    return MaterialApp(
      //coffee disease classifier application
      debugShowCheckedModeBanner: false,
      title: "CODICAP",
      home: const SignIn(),
      theme: theme,
    );
  }
}
