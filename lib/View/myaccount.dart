import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/View/Medaldetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Mymedals.dart';
import '../Controller/Personinfoc.dart';
import '../Widgets/Buttons.dart';
import '../globals.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Myaccount extends StatefulWidget {
  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passC = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            width: Get.width,
            height: Get.height - Get.statusBarHeight / 2,
            child: GetBuilder<PersonalinfoController>(
                builder: (_PersonalinfoController) {
              return Column(
                children: [
                  Expanded(child: GetBuilder<MedalsController>(
                      builder: (_MedalsController) {
                    return Container(
                      width: Get.width,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/sss.png',
                                fit: BoxFit.cover,
                                width: Get.width,
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'حساب الطالب',
                                        style: semibold.copyWith(
                                            color: Colors.white,
                                        fontSize: 12.sp),
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
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 35.w,
                              ),
                              Image.asset(
                                'assets/arrwdown.jpg',
                                fit: BoxFit.cover,
                                width: 50.w,
                              ),
                            ],
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                GetBuilder<PersonalinfoController>(
                                    builder: (_PersonalinfoController) {
                                  return Container(
                                    width: Get.width,
                                    // height: 100.h,
                                    color: Colors.white,
                                    child: Row(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(99999999),
                                          border: Border.all(width: 1, color: primcolor),
                                        ),
                                        child:
                                        Stack(
                                          children: [
                                        Obx(() {
                                          if(_PersonalinfoController.is_uploading.value==true) {
                                            return Container(
                                              width: 100.sp,
                                              height: 100.sp,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10000),
                                                border: Border.all(width: 1, color: primcolor),
                                              ),
                                              child: const ClipOval(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              width: 100.sp,
                                              height: 100.sp,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10000),
                                                border: Border.all(width: 1, color: primcolor),
                                              ),
                                              child: ClipOval(
                                                child: FullScreenWidget(
                                                  disposeLevel: DisposeLevel.Low,
                                                  child: Hero(
                                                    tag: "customTag1", // no animations now
                                                    child: Image.network(
                                                      authController.image_link.value,
                                                      //login_data.student.image,
                                                      // width: 100.sp,
                                                      // height: 100.sp,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                        Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: GestureDetector(
                                              child: Container(
                                                height:25.sp,
                                                width:25.sp,
                                                decoration: BoxDecoration(
                                                  color:Color.fromARGB(150, 255, 255, 255),
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: FittedBox(
                                                  child: Icon(Icons.camera_alt,color: Colors.grey,),
                                                ),
                                              ),
                                              onTap: (){
                                                _PersonalinfoController.pickImage();
                                                print(" i am a camera");
                                              },
                                            ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Text(
                                              authController.login_data.student.gender,
                                              style: semibold.copyWith(
                                                  color: Colors.grey,
                                                  height: 1,
                                              fontSize: 13.sp),
                                            ),
                                            Container(
                                              width: Get.width-125.w,
                                              child: Text(
                                                authController.login_data.student.name,
                                                style: semibold.copyWith(
                                                    fontSize: 16.sp,
                                                    color: primcolor,
                                                    height: 2),
                                                softWrap: true,
                                              ),
                                            ),
                                            Text(
                                              // 'الأول المتوسط',
                                              authController.login_data.student.study_year,
                                              style: semibold.copyWith(
                                                  color: Colors.grey,
                                                  height: 1,
                                                  fontSize: 13.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  );
                                }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      accitem(// _PersonalinfoController.id
                                          authController.login_data.student.id.toString(),"ID :"),
                                      accitem(//_PersonalinfoController.date
                                          authController.login_data.student.birth_date  ,"تاريخ الميلاد :"),
                                      accitem(//_PersonalinfoController.sonf
                                          authController.login_data.student.blood_group ,"زمرة الدم :"),
                                      accitem(//_PersonalinfoController.fatherphone
                                          authController.login_data.student.phone,"رقم ولي الأمر :"),
                                      accitem(//_PersonalinfoController.classs
                                          authController.login_data.student.study_year,"الصف :"),
                                      accitem(//_PersonalinfoController.fathername
                                          authController.login_data.student.parents_name,"اسم ولي الأمر :"),
                                      // accitem(_PersonalinfoController.mothername,"اسم الأم :"),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  })),
                ],
              );
            })),
      )),
    );
  }

  Widget accitem(String title,String main_title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row(
         textDirection: TextDirection.rtl,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           // Icon(Icons.family_restroom_outlined),
           Text(
             main_title,
             textDirection: TextDirection.rtl,

             style: semibold.copyWith(fontSize: 14.sp, color: Colors.grey[600]),
           ),
           SizedBox(width: 5.w,),
          Expanded(child: Container(
            child: Text(
              title,
              style: semibold.copyWith(fontSize: 14.sp, color: Colors.grey[400]),
              softWrap: true,
            ),
          )),

         ],
       ),
        Divider(
          color: Colors.grey[400],
          thickness: 2,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
