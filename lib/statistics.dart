import 'package:flutter/material.dart';

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,
      //Top bar with the logo
      // appBar: AppBar(
      //   backgroundColor: Mainbrown,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   toolbarHeight: 60,
      //   centerTitle: true,
      //   title: Image.asset(
      //     'assets/images/Logo.png',
      //     fit: BoxFit.contain,
      //     height: 70,
      //     width: 70,
      //     alignment: Alignment.center,
      //   ),
      // ),

      // endDrawer: CustomEndDrawer(),

      //Stats
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background Image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Mainbrown,
                ),
                alignment: const Alignment(0, -0.93),
                width: 390,
                height: 280,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Mainbeige,
                  ),
                  width: 220,
                  height: 45,
                  alignment: Alignment.topCenter,
                  child: const Text(
                    'إحصائيات الجمال',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
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
