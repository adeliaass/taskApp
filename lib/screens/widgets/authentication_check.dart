import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/screens/home_screen/home_screen.dart';
import 'package:flutter_do/screens/login_screen/signup_login_screen.dart';
import 'package:flutter_do/utils/enums.dart';

//User-Authentication-Check-Widget
class AuthenticationCheck extends StatelessWidget {
  const AuthenticationCheck({super.key});

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          final name = snapshot.data!.displayName ?? "USER";
          return ScreenHome(
            userName: name,
          );
        } else {
          return ScreenSignUpLogin(initialMode: UserMode.signup);
        }
      },
    );
  }
}
