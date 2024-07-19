import 'package:flutter/material.dart';
import 'package:flutter_do/screens/login_screen/widgets/user_form_builder.dart';
import 'package:flutter_do/utils/enums.dart';



// ignore: must_be_immutable
class ScreenSignUpLogin extends StatelessWidget {
  //userModeNotifier
  late ValueNotifier userModeNotifier;

  ScreenSignUpLogin({super.key, required UserMode initialMode})
      : userModeNotifier = ValueNotifier(initialMode);

  //keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        //Base-Column
        child: Column(
          children: [
            //Image-ClipRect
            ClipRRect(
              child: Image.asset(
                'assets/images/to-do-image.png',
              ),
            ),
            SizedBox(
              height: height * .05,
            ),

            //Text-Form & Buttons
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  //User-Form-Builder-Widget
                  child: UserFormBuilder(
                      userModeNotifier: userModeNotifier,
                      formKey: formKey,
                      width: width,
                      height: height,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      scaffoldKey: scaffoldKey)),
            ),
          ],
        ),
      ),
    );
  }
}
