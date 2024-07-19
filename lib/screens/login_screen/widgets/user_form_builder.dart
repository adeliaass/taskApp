import 'package:flutter/material.dart';

import 'package:flutter_do/screens/login_screen/widgets/user_authenticate_button.dart';
import 'package:flutter_do/utils/enums.dart';

class UserFormBuilder extends StatelessWidget {
  const UserFormBuilder({
    super.key,
    required this.userModeNotifier,
    required this.formKey,
    required this.width,
    required this.height,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.scaffoldKey,
  });

  final ValueNotifier userModeNotifier;
  final GlobalKey<FormState> formKey;
  final double width;
  final double height;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userModeNotifier,
        builder: (ctx, userMode, _) {
          return Form(
              key: formKey,
              child: Column(
                children: [
                  //Text form field container-1
                  (userMode == UserMode.signup)
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          width: width,
                          height: height * 0.05,
                          decoration: const BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextFormField(
                              controller: nameController,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Name'
                                      : null,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0))),
                        )
                      : const SizedBox(),
                  (userMode == UserMode.signup)
                      ? const SizedBox(
                          height: 30.0,
                        )
                      : const SizedBox(),

                  //Text form field container-2
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    width: width,
                    height: height * 0.05,
                    decoration: const BoxDecoration(
                        color: Color(0xFFedf0f8),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter Email'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0))),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  //Text form field container-3
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    width: width,
                    height: height * 0.05,
                    decoration: const BoxDecoration(
                        color: Color(0xFFedf0f8),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: TextFormField(
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter Password'
                            : null,
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0))),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  //Sign-Up Button-Container
                  UserAuthenticateButton(
                    width: width,
                    height: height,
                    formKey: formKey,
                    userModeNotifier: userModeNotifier,
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    scaffoldKey: scaffoldKey,
                    userMode: userMode,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //Login-Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          (userMode == UserMode.signup)
                              ? "Already have an account?"
                              : "New to the App?",
                          style: const TextStyle(
                              color: Color(0xFF8c8e98),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          userModeNotifier.value =
                              (userModeNotifier.value == UserMode.signup)
                                  ? UserMode.login
                                  : UserMode.signup;
                        },
                        child: Text(
                          (userMode == UserMode.signup) ? "LogIn" : "SignUp",
                          style: const TextStyle(
                              color: Color(0xFF273671),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
