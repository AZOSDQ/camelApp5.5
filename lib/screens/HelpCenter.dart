import 'HelpCenter_send.dart';
import '../Widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);
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
        backgroundColor: Color.fromRGBO(152, 78, 51, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        centerTitle: true,
        title: Image.asset(
          'assets/images/camelicon.png',
          fit: BoxFit.contain,
          height: 70,
          width: 70,
          alignment: Alignment.center,
        ),
      ),
      endDrawer: CustomEndDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
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
                color: Color.fromRGBO(152, 78, 51, 1),
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
      ),
    );
  }
}
