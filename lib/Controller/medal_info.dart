import 'dart:convert';

import 'package:get/get.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/Models/competetion_model.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/globals.dart';
class MedalInfo extends GetxController{
  var loginController = Get.find<AuthController>();
  Competetion competetion=Competetion();
  var id4medal='-1'.obs;
  getInfoMedal(id_medal)async{
    try{
      http.Response response= await http.get(Uri.parse('$API_Competetion_Show$id_medal'),
          headers: {
            'Accept':'application/json',
            'Authorization':'Bearer ${loginController.login_data.access_token}'
          });
      var json=response.body;
      competetion= Competetion.fromJson(jsonDecode(json));
    }catch(e){
      print("====HAHAHAHAHA=====\n $e");
    }
  }
}