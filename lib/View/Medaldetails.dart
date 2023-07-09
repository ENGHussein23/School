import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/Controller/medal_info.dart';

import 'package:salateapp/Models/competetion_model.dart';
import 'package:http/http.dart' as http;
import 'package:salateapp/globals.dart';
import '../Models/medlaModel.dart';
import '../Controller/Personinfoc.dart';
import 'package:full_screen_image/full_screen_image.dart';
class MedalDetails extends StatefulWidget {
  Medalesmodel? medal;
  MedalDetails(this.medal);
  @override
  State<MedalDetails> createState() => _MedalDetailsState();
}

class _MedalDetailsState extends State<MedalDetails> {
  final authController = Get.find<AuthController>();
  // final info=Get.put(MedalInfo());
  Competetion competetion=Competetion();
  @override
  void initState() {
    competetion.data.name="جار التحميل";
    competetion.data.description="جار التحميل";
    competetion.data.how_to_win="جار التحميل";
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
      child: Scaffold(body: GetBuilder<PersonalinfoController>(
          builder: (_PersonalinfoController) {
        return Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Container(
                    width: Get.width,
                    // height: Get.height - Get.statusBarHeight / 2,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/medaldetails.jpg',
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 15.h,
                              left: 20.w,
                              child: GetBuilder<PersonalinfoController>(
                                  builder: (_PersonalinfoController) {
                                    return Container(
                                      width: Get.width,
                                      height: 90.h,
                                      child: Row(children: [
                                        Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  authController.login_data.student.gender,
                                                  style:
                                                  semibold.copyWith(color: Colors.white,fontSize: 12.sp),
                                                ),
                                                Text(
                                                  authController.login_data.student.name,
                                                  style: semibold.copyWith(
                                                      fontSize: 15.sp, color: Colors.white),
                                                ),
                                                Text(
                                                  authController.login_data.student.study_year,
                                                  style:
                                                  semibold.copyWith(color: Colors.white,fontSize: 12.sp),
                                                ),
                                              ],
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Obx(() =>  Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10000),
                                            border: Border.all(width: 1, color: primcolor),
                                          ),
                                          child: ClipOval(
                                            child: FullScreenWidget(
                                              disposeLevel: DisposeLevel.Low,
                                              child: Hero(
                                                tag: "customTag2",
                                                child: Image.network(
                                                  authController.image_link.value,
                                                  width: 70.sp,
                                                  height: 70.sp,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ]),
                                    );
                                  }),
                            ),
                            Positioned(
                              bottom: 70.h,
                              left: 20.w,
                              child: Image.network(
                                widget.medal!.image.toString(),
                                width: 130.w,
                                height: 130.w,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            Image.asset(
                              'assets/arrwdown.jpg',
                              width: 50.w,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.w,
                            ),
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                  color: primcolor.withOpacity(0.2),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              // widget.medal!.name.toString(),
                              competetion.data.name,
                              style: semibold.copyWith(color: primcolor,fontSize: 12.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.w,
                            ),
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                  color: primcolor.withOpacity(0.2),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: Get.width-100.w,
                              child: Text(
                                competetion.data.description,
                                style: semibold.copyWith(color: primcolor,fontSize: 12.sp),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.w,
                            ),
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                  color: primcolor.withOpacity(0.2),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              width: Get.width-100.w,
                              child: Text(
                                competetion.data.how_to_win,
                                style: semibold.copyWith(color: primcolor,fontSize: 12.sp),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
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
        );
      })),
    );
  }
}
