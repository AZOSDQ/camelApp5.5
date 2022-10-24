import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../screens/confirmationPage.dart';
import '../screens/loginPage.dart';
import '../screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../services/provider.dart';

class AuthService {
  signUp(email, username, password, context) async {
    try {
      var userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email
      };
      Amplify.Auth.signUp(
              username: username,
              password: password,
              options: CognitoSignUpOptions(userAttributes: userAttributes))
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => ConfirmationPage(
                    username: username,
                  )))));
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  //confirm user
  confirmUser(username, confirmationCode, context) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);
      if (res.isSignUpComplete) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  //Sign In
  signIn(username, password, context) async {
    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: username, password: password);
      if (res.isSignedIn) {
        UserLoggedIn().setUserCurrentState(true);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Splash()));
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  //sign out
  signOut(context) async {
    SignOutResult res = await Amplify.Auth.signOut();
    UserLoggedIn().setUserCurrentState(false);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
