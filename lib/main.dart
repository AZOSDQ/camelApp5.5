import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camelapp/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'splash.dart';

Future<void> main() async {
  // new initialize amplify to the app
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth, storage]);

    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('the error is $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeApp();
  // }

  // Future<void> _initializeApp() async {
  //   //await AmplifyService.configureAmplify(); // note the await!

  //   setState(() {
  //     var _isLoading = false; // important to set the state!
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 240, 199, 1),
          fontFamily: 'DINNextLTArabic',
        ),
        debugShowCheckedModeBanner: false,
        home: const Splash(),
      ),
    );
  }
}
