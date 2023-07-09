import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/Models/competetion_model.dart';
import 'package:salateapp/Models/competetions_index_model.dart';
import 'package:salateapp/Models/medlaModel.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/Widgets/Buttons.dart';
import 'package:salateapp/globals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class MedalsController extends GetxController {
  List<Medalesmodel> medals = [];
  var medals_length=0.obs;
  var loginController = Get.find<AuthController>();
  AllCompetitions allCompetitions=AllCompetitions();
  @override
  void onInit() {
  getmedals();
    super.onInit();
  }
  var medalloded = false.obs;

  Future<void> getmedals() async {
    try{
      http.Response response= await http.get(Uri.parse('$API_URL$API_Competetion_Index'),
          headers: {
            'Accept':'application/json',
            'Authorization':'Bearer ${loginController.login_data.access_token}'
          });
      var json=response.body;
      allCompetitions= AllCompetitions.fromJson(jsonDecode(json));
    }catch(e){
      print("====HAHAHAHAHA=====\n $e");
    }
    medalloded.value = false;
    late List<IndexCompetition> wonAndOther=allCompetitions.data.won+allCompetitions.data.other;
    for (int i = 0; i < wonAndOther.length; i++) {
      medals.add(Medalesmodel({
        'id':wonAndOther[i].id,
        'name': wonAndOther[i].id,
        'image': wonAndOther[i].icon,
        'selected': allCompetitions.data.won.contains(wonAndOther[i]) ? '1' : '0',
      }));
    }
    if(medals_length.value!=medals.length)
      {
        medals_length.value=medals.length;
        update();
      }
    medalloded.value = true;
    // update();
  }
  var isLoading = false.obs;

  Future<void> downloadImage(String imageUrl, String fileName) async {
    print("================================================");
    print(imageUrl);
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getExternalStorageDirectory();
      final mySchoolDir = Directory('${directory!.path}/أوسمتي/');
      await mySchoolDir.create(recursive: true);
      final file = File('${mySchoolDir.path}/$fileName.jpg');
      await file.writeAsBytes(response.bodyBytes);
      isLoading.value = false;
      Get.dialog(
        AlertDialog(
          title: const Text('تم تحميل الصورة بنجاح'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تم حفظ الوسام في هذا المسار:'),
              const SizedBox(height: 8),
              Text(file.path,textDirection: TextDirection.ltr,),
            ],
          ),
          actions: [
            Center(child: button1('حسنا', () {Get.back();}),)
          ],
        ),
      );

      print("file.path ${file.path}\nfile.uri ${file.uri}\nfile.parent ${file.parent}\n");
      print("================================================");
    } catch (e) {
      isLoading.value = false;
      Get.dialog(
        AlertDialog(
          title: const Text('يوجد خطأ في عملية تحميل الصورة'),
          content: const Text('الرجاء التأكد من اتصال الشبكة'),
          actions: [
            Center(child: button1('حسنا', () {Get.back();}),)
          ],
        ),
      );
      print('$e');
    }
  }
}
