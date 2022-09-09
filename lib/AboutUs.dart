import 'package:flutter/material.dart';

import 'widgets/CustomEndDrawer.dart';

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,

      //The top bar
      appBar: AppBar(
        backgroundColor: Mainbrown,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo.png',
          fit: BoxFit.contain,
          height: 70,
          width: 70,
          alignment: Alignment.center,
        ),
      ),
      endDrawer: const CustomEndDrawer(),
      //About us text
      body: Column(
        children: const [
          SizedBox(height: 50),
          Align(
            alignment: Alignment(0.6, 0),
            child: Text(
              'تم صنع هذا التطبيق\n من قبل:',
              style: TextStyle(
                fontSize: 31,
                fontFamily: 'DINNextLTArabic',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment(0.6, 0),
            child: Text(
              '1-نواف الخلف\n2-سليمان الحربي\n3-عبدالعزيز الصديق\n4-عبدالعزيز الحصيني',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'DINNextLTArabic',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
