import 'package:flutter/material.dart';
import 'GeneralInformations.dart';
import 'History.dart';
import 'TakePicture.dart';
import 'statistics.dart';
import 'AboutUs.dart';
import 'HelpCenter.dart';
import 'Home.dart';
import 'widgets/CustomEndDrawer.dart';

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class MyHomePage extends StatefulWidget {
  static int CurrentTab = 0;
  static Widget currentScreen = Home();

  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold);

  final List<Widget> screens = [
    const Home(),
    const TakePicture(),
    const Statistics(),
    const GetInfoWidget(),
    const History(),
    const HelpCenter(),
    const AboutUs(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      extendBody: true,

      body: PageStorage(
        child: MyHomePage.currentScreen,
        bucket: bucket,
      ),
      //camera button in the middle
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          _CameraPopup(context);
        },
        backgroundColor: Color.fromRGBO(71, 59, 45, 1),
        elevation: 30,
      ),
      //creating the bottom app bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Mainbrown,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Left hand icons (Home and Statistics)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Home button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        MyHomePage.currentScreen = Home();
                        MyHomePage.CurrentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MyHomePage.CurrentTab == 0
                              ? Icons.home
                              : Icons.home_outlined,
                          size: 30,
                        ),
                        const Text(
                          'الرئيسية',
                          style: TextStyle(
                            fontFamily: 'DINNextLTArabic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Statistics Button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        MyHomePage.currentScreen = Statistics();
                        MyHomePage.CurrentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MyHomePage.CurrentTab == 1
                              ? Icons.analytics
                              : Icons.analytics_outlined,
                          size: 35,
                        ),
                        const Text(
                          'الإحصائيات',
                          style: TextStyle(
                            fontFamily: 'DINNextLTArabic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Right hand icons (History and General Information)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //History button
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        MyHomePage.currentScreen = History();
                        MyHomePage.CurrentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MyHomePage.CurrentTab == 2
                              ? Icons.history
                              : Icons.history_outlined,
                          size: 35,
                        ),
                        const Text(
                          'السجل',
                          style: TextStyle(
                            fontFamily: 'DINNextLTArabic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //General Information
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        MyHomePage.currentScreen = GetInfoWidget();
                        MyHomePage.CurrentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //create icon
                        Icon(
                          MyHomePage.CurrentTab == 3
                              ? Icons.info
                              : Icons.info_outlined,
                          size: 35,
                        ),
                        //the label of the icon
                        const Text(
                          'أنواع الإبل',
                          style: TextStyle(
                            fontFamily: 'DINNextLTArabic',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _CameraPopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Mainbrown,
            ),
            child: Column(children: [
              const Text(
                'رفع صورة',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 30),
              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Mainbeige,
                ),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _CameraPopup(context);
                  },
                  child: const Text(
                    'من الكاميرا',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Mainbeige,
                ),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _CameraPopup(context);
                  },
                  child: const Text(
                    'من ألبوم الصور',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 40,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
          );
        });
  }
}
