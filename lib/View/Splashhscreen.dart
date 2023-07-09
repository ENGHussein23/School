import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Loginscreen1.dart';

class Splashhscreen extends StatefulWidget {
  @override
  State<Splashhscreen> createState() => _SplashhscreenState();
}

class _SplashhscreenState extends State<Splashhscreen> {
  @override
  void initState() {
    final timer = Timer(
      const Duration(seconds: 5),
      () {
        Get.offAll(LoginScreen1());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
            )));
  }
}
