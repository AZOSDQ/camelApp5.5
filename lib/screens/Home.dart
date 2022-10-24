import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold);
  //new functions to upload images

  late File _photo;
  final ImagePicker imagepicker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await imagepicker.pickImage(source: ImageSource.gallery);
    var currentUser = await Amplify.Auth.getCurrentUser();
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    var userid = currentUser.userId;
    var uuid = const Uuid().v4();
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
    final pickedFile = await imagepicker.pickImage(source: ImageSource.camera);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,
      body: Container(
        //Background Image

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //welcoming messege and a start button
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'مرحبا بك في تطبيق\nجملي',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'يتيح لك التطبيق التعرف على\nنوع الجمال بواسطة الصور',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              //Take an image button
              const SizedBox(height: 50),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(142, 99, 83, 0.8),
                  ),
                  width: 200,
                  height: 190,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      cameraPopUp(context);
                    },
                    child: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 35,
                          textDirection: TextDirection.rtl,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "اضغط هنا للتعرف على نوع الجمل",
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'DINNextLTArabic',
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
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
