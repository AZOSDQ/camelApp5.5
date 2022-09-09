import 'package:flutter/material.dart';
import 'GeneralInformations.dart';
import 'History.dart';
import 'TakePicture.dart';
import 'statistics.dart';
import 'package:camelapp/splash.dart';

void main() {
  runApp(const MyApp());
}

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

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
