import 'dart:convert';
import 'package:salateapp/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
   try{
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
       is_loading_login.value=false;
       final responseData = json.decode(response.body);
       login_data=Login.fromJson(responseData);
       await sharedpref.setString('token', login_data.access_token);
       await sharedpref.setString('user', jsonEncode(login_data.toJson()));
       await sharedpref.setString('image', login_data.student.image);
       image_link.value=login_data.student.image;
       print("/////////////////////////////////////");
       print(login_data.student.image);
       print("/////////////////////////////////////");
       // Save token to local storage or state management
       // login_data_global=login_data;
       Get.to(HomeScreen());
       // return true;
     }
     else {
       // Login failed
       if (response.statusCode == 401) {
         // Unauthorized

         is_loading_login.value=false;
         Get.dialog(AlertDialog(
           title: const Text('فشل تسجيل الدخول'),
           content: const Text('يوجد خطأ في رقم الجوال او كلمة المرور'),
           actions: [Center(child: button1('اعادة المحاولة', () {Get.back();}),)],
         ),);
       }
       else{
         is_loading_login.value=false;
         Get.dialog(AlertDialog(
           title: const Text('فشل تسجيل الدخول'),
           content: const Text('يوجد خطأ في عملية تسجيل الدخول , الرجاء التأكد من الاتصال بالشبكة و المحاولة لاحقا'),
           actions: [Center(child: button1('اعادة المحاولة', () {Get.back();}),)],
         ),);
         // return false;
       }
     }
   }catch(e){
     print("======this is e $e");
   }
  }
}