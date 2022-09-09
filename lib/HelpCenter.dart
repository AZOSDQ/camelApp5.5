import 'HelpCenter_send.dart';
import 'package:flutter/material.dart';
import 'BottomNavigator.dart';
import 'widgets/CustomEndDrawer.dart';

const Mainbrown = Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = Color.fromRGBO(230, 203, 160, 1);
final scaffoldKey = GlobalKey<ScaffoldState>();

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenter();
}

class _HelpCenter extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,
      //Top bar with the logo
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Card(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'بريدك الإلكتروني',
                    hintTextDirection: TextDirection.rtl,
                    fillColor: Colors.blue),
              ),
            ),
            const Card(
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'أكتب المشكلة التي تعاني منها',
                    hintTextDirection: TextDirection.rtl,
                    fillColor: Colors.blue),
              ),
            ),
            Card(
              color: Mainbrown,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HelpCenter2()),
                    );
                  },
                  child: const Text(
                    "إرسال",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'DINNextLTArabic',
                        color: Colors.black),
                    textAlign: TextAlign.right,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
