import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/Controller/Mymedals.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/Controller/medal_info.dart';
import 'package:salateapp/Models/competetion_model.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/globals.dart';
import '../Models/medlaModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedalDetails2 extends StatefulWidget {
  Medalesmodel? medal;
  MedalDetails2(this.medal);
  @override
  State<MedalDetails2> createState() => _MedalDetailsState();
}

class _MedalDetailsState extends State<MedalDetails2> {
  final authController = Get.find<AuthController>();
  final mdalsController=Get.put(MedalsController());
 Competetion competetion=Competetion();

  @override
  void initState() {
    competetion.data.name='جار التحميل';
    competetion.data.colored_icon='null';
    super.initState();
    setState(() {

      getInfoMedal( widget.medal!.id!);
    });
  }
  getInfoMedal(id_medal)async{
    try{
      http.Response response= await http.get(Uri.parse('$API_Competetion_Show$id_medal'),
          headers: {
            'Accept':'application/json',
            'Authorization':'Bearer ${authController.login_data.access_token}'
          });
      var json=response.body;
      setState(() {
        competetion= Competetion.fromJson(jsonDecode(json));
      });
    }catch(e){
      print(" $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
              children: [
                Container(
                    width: Get.width,
                    height: Get.height - Get.statusBarHeight / 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/uppbar3.png',
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 20.h,
                                left: 20.w,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        // widget.medal!.name.toString(),
                                        competetion.data.name,
                                        style:
                                        semibold.copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding:  EdgeInsets.all(20.0.w),
                            child: Container(
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 15.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: primcolor.withOpacity(0.3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'مبروك',
                                        style: semibold.copyWith(
                                            fontSize: 22.sp, color: primcolor),
                                      ),
                                      Text(
                                        'إكتمل التحدي',
                                        style: semibold.copyWith(
                                            fontSize: 14.sp,
                                            color: Colors.blueGrey),
                                      )
                                    ],
                                  ),
                                  Obx(() {
                                    if(mdalsController.isLoading.value==true) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return InkWell(
                                        onTap: (){
                                          mdalsController.downloadImage(competetion.data.colored_icon, '${competetion.data.name}');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: primcolor),
                                          child: Row(
                                            children: [
                                              Text(
                                                'تحميل',
                                                style: semibold.copyWith(
                                                    color: Colors.white,fontSize: 12.sp),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            competetion.data.name,
                            style: semibold.copyWith(
                                fontSize: 22.sp, color: primcolor),
                          ),
                          SizedBox(
                            height: Get.height/3,
                            child: Padding(
                              padding:  EdgeInsets.all(20.0.w),
                              child:competetion.data.colored_icon=='null'?Image.asset("assets/medal3333.jpg"): Image.network(competetion.data.colored_icon),
                            ),
                          )
                          // Expanded(
                          //     child: Padding(
                          //       padding:  EdgeInsets.all(20.0.w),
                          //       child:competetion.data.colored_icon=='null'?Image.asset("assets/medal3333.jpg"): Image.network(competetion.data.colored_icon),
                          //     )),
                        ],
                      ),
                    )
                    ),
                Visibility(
                  // visible: competetion.data.name=="جار التحميل",
                    visible: false,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black45
                      ),
                      width: Get.width,
                      height: Get.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ))
              ],
            ),
          ),
    );
  }
}
