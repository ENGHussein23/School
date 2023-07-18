import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/Models/login_model.dart';
import 'package:salateapp/Widgets/Buttons.dart';
import 'package:salateapp/globals.dart';
import 'package:salateapp/main.dart';
class PersonalinfoController extends GetxController {
  var loginController = Get.find<AuthController>();
  @override
  void onInit() {
    setinfo({
      'name': 'محمد أحمد علي',
      'fathername': 'أحمد علي',
      'mothername': 'حسناء حسن',
      'classs': 'الصف الأول',
      'email': 'example"gmail.com',
      'image': 'pers.png',
      'gender': 'ذكر',
      'date': '12/3/2020',
      'access_token': 'access_token',
      'id': 'id',
      'sonf': 'O+',
      'fatherphone': '092238838833'
    }, 'dd');
    super.onInit();
  }

  var name = '-1';
  var fathername = '-1';
  var mothername = '-1';
  var classs = '-1';
  var email = '-1';
  var image = '-1';
  var gender = '-1';
  var password = '-1';
  var date = '-1';
  var access_token = '-1';
  var id = '-1';
  var fatherphone = '-1';
  var sonf = '-1';
  var login = false;
  void setinfo(dynamic x, String password1) {
    password = password1;
    image = x['image'].toString();
    access_token = x['access_token'].toString();
    name = x['name'].toString();
    fathername = x['fathername'].toString();
    mothername = x['mothername'].toString();
    classs = x['classs'].toString();
    email = x['email'].toString();
    sonf = x['sonf'].toString();
    gender = x['gender'].toString();

    date = x['date'].toString();

    id = x['id'].toString();
    fatherphone = x['fatherphone'].toString();
    update();
  }


var is_uploading=false.obs;
  Future<void> pickImage() async {
    try {

      final imageUpdated = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageUpdated == null) return;
      try {
        is_uploading.value=true;
        var request = http.MultipartRequest('POST', Uri.parse(API_Update_Image));
        var multipartFile = await http.MultipartFile.fromPath('image', imageUpdated.path);
        request.headers.addAll({
          'Accept':'application/json',
          'Authorization':'Bearer ${loginController.login_data.access_token}'
        });
        request.files.add(multipartFile);
        var response = await request.send();
        print("response.statusCode ${response.statusCode}");
        if (response.statusCode == 200) {
          is_uploading.value=false;
          print('Image uploaded successfully');
          var responseBodyString = await response.stream.bytesToString();
          var jsonRes = json.decode(responseBodyString);
          if (jsonRes != null && jsonRes['data'] != null && jsonRes['data']['image'] != null) {
            loginController.login_data.student.image = API_Images_Url+jsonRes['data']['image'];
            loginController.image_link.value=loginController.login_data.student.image;
            await sharedpref.setString('image', loginController.login_data.student.image);
            print('Image updated successfully');
          } else {
            is_uploading.value=false;
            Get.dialog(AlertDialog(
              title: const Text('فشل تحديث الصورة'),
              content: const Text('الرجاء القيام باعادة المحاولة'),
              actions: [button1('فهمت', () {Get.back();})],
            ),);
            print('Failed to update image: unexpected response data');
          }
        } else {
          is_uploading.value=false;
          Get.dialog(AlertDialog(
            title: const Text('فشل في عملية رفع الصورة'),
            content: const Text('الرجاء القيام باعادة المحاولة'),
            actions: [button1('فهمت', () {Get.back();})],
          ),);
          print('Failed to upload image: ${response.statusCode}');
        }
      } catch (e) {
        is_uploading.value=false;
        print('Error uploading image: $e');
      }
    } catch (e) {
      is_uploading.value=false;
      Get.dialog(AlertDialog(
        title: const Text('فشل في عملية اختيار الصورة'),
        content: const Text('الرجاء القيام باعادة المحاولة'),
        actions: [button1('فهمت', () {Get.back();})],
      ),);
      print('Failed to pick image: $e');
    }
  }
}
