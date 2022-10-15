import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wekeep/app/ui/theme/color_theme.dart';

import '../controllers/authentication_controller.dart';
import 'package:getwidget/getwidget.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({Key? key}) : super(key: key);
  final AuthenticationController controller =
      Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      backgroundColor: kprimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kprimaryColor,
        centerTitle: true,
        // title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'WeKeep',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Quality service at your doorstep!',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
            Center(
              child: Container(
                child: SvgPicture.asset('assets/images/login.svg'),
                height: height * 0.4,
                width: width * 0.5,
              ),
            ),
            Column(
              children: [
                Text(
                  "Welcome back! To get started, please login!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                )
              ],
            ),
            Center(
              child: SignInButton(Buttons.Google,
                  onPressed: () => controller.loginWithGoogle()),
            ),
          ],
        ),
      ),
    );
  }
}
