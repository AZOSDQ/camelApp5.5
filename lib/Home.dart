import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'BottomNavigator.dart' as navigator;

import 'package:path/path.dart';

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
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    File pickedFile =
        (await _picker.pickImage(source: ImageSource.gallery)) as File;

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
    var imageCounter = navigator.imageCounter;
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('image$imageCounter');
      navigator.imageCounter++;
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  //Image picker method (to open either camera or gallery to pick an image)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,
      body:
          //Background Image
          Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Best Background so far.png"),
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

              //Take an image button
              const SizedBox(height: 50),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Mainbrown,
                  ),
                  width: 200,
                  height: 190,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      _CameraPopup(context);
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
                            'تعرف على نوع الجمل',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'DINNextLTArabic',
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'اضغط هنا\nلتحديد صورة الجمل',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'DINNextLTArabic',
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.right,
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

  void _CameraPopup(context) {
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
