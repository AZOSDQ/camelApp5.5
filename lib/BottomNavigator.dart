import 'dart:io';

import 'package:path/path.dart';

import 'Widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import 'GeneralInformations.dart';
import 'History.dart';
import 'TakePicture.dart';
import 'statistics.dart';
import 'AboutUs.dart';
import 'HelpCenter.dart';
import 'Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);
var imageCounter = 0;

class MyHomePage extends StatefulWidget {
  static int CurrentTab = 0;
  static Widget currentScreen = Home();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold);

  //new functions to upload images
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    const destination = 'files/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('image$imageCounter');
      imageCounter++;
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

//list to switch between the 4 bottom screens
  final List<Widget> screens = [
    Home(),
    TakePicture(),
    Statistics(),
    const GetInfoWidget(),
    History(),
    HelpCenter(),
    AboutUs(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  //Image picker method (to open either camera or gallery to pick an image)
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the top appbar with the logo
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Mainbrown,
        iconTheme: IconThemeData(color: Colors.black),
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
      //call the drawer
      endDrawer: CustomEndDrawer(),
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
        shape: CircularNotchedRectangle(),
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
                          size: 35,
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
                  //open the camera on press to take a picture
                  onPressed: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
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
                    imgFromGallery();
                    Navigator.of(context).pop();
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
