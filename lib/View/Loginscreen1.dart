import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../globals.dart';
import 'LoginScreen.dart';

class LoginScreen1 extends StatefulWidget {
  @override
  State<LoginScreen1> createState() => LoginScreen1State();
}

class LoginScreen1State extends State<LoginScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              'assets/2.jpg',
              fit: BoxFit.cover,
            )),
        Positioned(
          bottom: 50,
          left: Get.width / 2 - 100,
          right: Get.width / 2 - 100,
          child: InkWell(
            onTap: () {
              Get.to(LoginScreen());
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.white)),
              child: Center(
                  child: Text(
                'تسجيل الدخول',
                style: semibold.copyWith(color: Colors.white),
              )),
            ),
          ),
        )
      ],
    ));
  }
}
