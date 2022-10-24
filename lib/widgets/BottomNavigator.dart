import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import '../screens/GeneralInformations.dart';
import '../screens/History.dart';
import '../screens/TakePicture.dart';
import '../screens/statistics.dart';
import '../screens/AboutUs.dart';
import '../screens/HelpCenter.dart';
import '../screens/Home.dart';
import 'package:image_picker/image_picker.dart';

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

  File? photo;
  final ImagePicker imagePicker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    var currentUser = await Amplify.Auth.getCurrentUser();
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    var userid = currentUser.userId;
    // Upload image with the current time as the key
    final key = "$userid/$uuid.jpg";
    final file = File(pickedFile.path);
    const snackBar = SnackBar(content: Text("uploaded"));
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Successfully uploaded image: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    var currentUser = await Amplify.Auth.getCurrentUser();
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    var userid = currentUser.userId;
    var authuser = AmplifyAuthCognito().getCurrentUser();
    // Upload image with the current time as the key
    final key = "$userid/$uuid.jpg";
    final file = File(pickedFile.path);
    const snackBar = SnackBar(content: Text("uploaded"));
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Successfully uploaded image: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading image: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the top appbar with the logo
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(152, 78, 51, 1),
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        centerTitle: true,
        title: Image.asset(
          'assets/images/camelicon.png',
          fit: BoxFit.contain,
          height: 65,
          width: 65,
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
          cameraPopUp(context);
        },
        backgroundColor: Color.fromRGBO(152, 78, 51, 1),
        elevation: 30,
      ),

      //creating the bottom app bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(152, 78, 51, 1),
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

  void cameraPopUp(context) {
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
