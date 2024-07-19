import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/database/models/user_model.dart';
import 'package:flutter_do/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:flutter_do/screens/home_screen/home_screen.dart';
import 'package:flutter_do/utils/enums.dart';

class UserAuthenticateButton extends StatelessWidget {
  const UserAuthenticateButton(
      {super.key,
      required this.width,
      required this.height,
      required this.formKey,
      required this.userModeNotifier,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.scaffoldKey,
      required this.userMode});

  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  final ValueNotifier userModeNotifier;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final UserMode userMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
      width: width,
      height: height * 0.05,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: ElevatedButton(
        onPressed: () async {
          //Validate Crentials
          if (formKey.currentState!.validate()) {
            dynamic result;
            //Sign-Up
            if (userModeNotifier.value == UserMode.signup) {
              result = await FirebaseAuthFunctions.instance
                  .registerUserUsingEmail(nameController.text,
                      emailController.text, passwordController.text);
            } //Login
            else {
              result = await FirebaseAuthFunctions.instance
                  .authenticateUserUsingEmail(
                      emailController.text, passwordController.text);
            }
            if (result is UserModel) {
              //User-Authentication-Successful
              final userName = result.userName;

              Navigator.of(scaffoldKey.currentContext!)
                  .pushReplacement(MaterialPageRoute(
                      builder: (ctx) => ScreenHome(
                            userName: userName,
                          )));
            } else if (result is FirebaseAuthException) {
              //User-Authentication-Failed
              ScaffoldMessenger.of(scaffoldKey.currentContext!)
                  .showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        result.message!,
                        style: const TextStyle(fontSize: 18.0),
                      )));
            }
          }
        },
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C9FF)),
        child: Text(
          (userMode == UserMode.signup) ? 'Sign Up' : 'Log In',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
