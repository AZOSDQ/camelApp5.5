import 'package:flutter/material.dart';

import 'TakePicture.dart';

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,

//Hamburger menu (The Drawer)
      // endDrawer: CustomEndDrawer(),

      body:
          //Background Image
          Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background Image.png"),
            fit: BoxFit.cover,
          ),
        ),
        //welcoming messege and a start button
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const Text(
                'مرحبا بك في تطبيق\nجملي',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              const Text(
                'يتيح لك التطبيق التعرف على\nنوع الجمال بواسطة الصور',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              //Start here Button
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Mainbrown,
                ),
                width: 135,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const TakePicture()),
                    );
                  },
                  child: const Text(
                    'اضغط هنا للبدء',
                    style: TextStyle(
                      fontSize: 20,
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
