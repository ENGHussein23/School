import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/View/Home.dart';

import 'Loginscreen1.dart';

class Splashhscreen extends StatefulWidget {
  final String home;
  Splashhscreen(this.home);

  @override
  State<Splashhscreen> createState() => _SplashhscreenState();
}

class _SplashhscreenState extends State<Splashhscreen> {
  @override
  void initState() {
    final timer = Timer(
      const Duration(seconds: 2),
      () {
        widget.home=='0'?
        Get.offAll(LoginScreen1())
        :Get.offAll(HomeScreen());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            widget.home=='0'?
            Get.offAll(LoginScreen1())
                :Get.offAll(HomeScreen());
          },
          child: Container(
              width: Get.width,
              height: Get.height,
              child: Image.asset(
                'assets/1.png',
                fit: BoxFit.cover,
              )),
        ));
  }
}
