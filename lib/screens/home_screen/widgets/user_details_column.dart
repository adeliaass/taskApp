import 'package:flutter/material.dart';
import 'package:flutter_do/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:flutter_do/screens/login_screen/signup_login_screen.dart';
import 'package:flutter_do/utils/enums.dart';

class UserDetailsColumn extends StatelessWidget {
  const UserDetailsColumn(
      {super.key,
      required this.userName,
      required this.getHour,
      required this.height});

  final String userName;
  final String Function() getHour;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //User name Text
            Text(
              'HELLO\n${userName.toUpperCase()}',
              style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 40, 144, 241)),
            ),
            //Sign-Out-Button
            IconButton(
                onPressed: () {
                  FirebaseAuthFunctions.instance.signOutUser();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) =>
                          ScreenSignUpLogin(initialMode: UserMode.login)));
                },
                icon: const Row(
                  children: [
                    //Sign-Out-Icon
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    //Sign-Out-Text
                    Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ))
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),

        //Greetings-Text
        Text(
          getHour(),
          style: const TextStyle(
              color: Color.fromARGB(153, 34, 34, 34),
              fontSize: 25.0,
              fontFamily: 'PlayWriteNGModern',
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: height * 0.03,
        ),
      ],
    );
  }
}
