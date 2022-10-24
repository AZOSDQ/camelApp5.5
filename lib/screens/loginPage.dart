import 'SignUpPage.dart';
import '../services/provider.dart';
import '../services/AuthService.dart';
import '../screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class LoginPage extends StatefulHookWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username, password;
  late bool userSignedIn;

  @override
  Widget build(BuildContext context) {
    userSignedIn = UserLoggedIn().getUserCurrentState();
    return Scaffold(
      backgroundColor: Mainbeige,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(152, 78, 51, 1),
        iconTheme: const IconThemeData(color: Colors.black),
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background6.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 300,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'اسم المستخدم',
                          hintTextDirection: TextDirection.rtl),
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'كلمة المرور',
                          hintTextDirection: TextDirection.rtl),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(152, 78, 51, 1),
                        ),
                        onPressed: () {
                          if (userSignedIn == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Splash()));
                          } else {
                            AuthService().signIn(username, password, context);
                          }
                        },
                        child: const Center(
                          child: Text(
                            'تسجيل الدخول',
                          ),
                        )),
                    const SizedBox(height: 10.0),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                        },
                        child: const Center(
                          child: Text(
                            'ليس لدي حساب',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 3,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
