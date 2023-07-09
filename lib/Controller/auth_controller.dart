import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/Models/login_model.dart';
import 'package:salateapp/View/Home.dart';
import 'package:salateapp/Widgets/Buttons.dart';
import 'package:salateapp/globals.dart';

class AuthController extends GetxController {
  late Login login_data;
var image_link=''.obs;
var is_loading_login=false.obs;
  login(String phone, String password) async {
    is_loading_login.value=true;
    final response = await http.post(
        Uri.parse(Auth_URL),
        body: {
          'phone': phone,
          'password': password,
    },
        headers: {
          'Accept':'application/json'
    });

    if (response.statusCode == 200) {
      // Login successful
      final responseData = json.decode(response.body);
      login_data=Login.fromJson(responseData);
      image_link.value=login_data.student.image;
      for(int i=0;i<10;i++) print("====${login_data.student.name}====");
      // Save token to local storage or state management
      login_data_global=login_data;
      is_loading_login.value=false;
      Get.to(HomeScreen());
      // return true;
    }
    else if (response.statusCode == 401) {
      // Unauthorized

      is_loading_login.value=false;
      Get.dialog(AlertDialog(
          title: const Text('فشل تسجيل الدخول'),
          content: const Text('يوجد خطأ في رقم الجوال او كلمة المرور'),
          actions: [Center(child: button1('اعادة المحاولة', () {Get.back();}),)],
        ),);
    }else {
      // Login failed

      is_loading_login.value=false;
      Get.dialog(AlertDialog(
        title: const Text('فشل تسجيل الدخول'),
        content: const Text('يوجد خطأ في عملية تسجيل الدخول , الرجاء التأكد من الاتصال بالشبكة و المحاولة لاحقا'),
        actions: [Center(child: button1('اعادة المحاولة', () {Get.back();}),)],
      ),);
      // return false;
    }
  }
}