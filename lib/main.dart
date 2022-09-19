import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camelapp/splash.dart';

Future<void> main() async {
  // new initialize firebase to the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
        fontFamily: 'DINNextLTArabic',
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
