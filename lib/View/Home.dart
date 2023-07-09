import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:salateapp/View/LoginScreen.dart';
import 'package:salateapp/View/Medaldetails.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Controller/Mymedals.dart';
import '../Controller/Personinfoc.dart';
import '../globals.dart';
import 'medaldetails2.dart';
import 'myaccount.dart';
import 'package:full_screen_image/full_screen_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.find<AuthController>();
  final medalsController = Get.put(MedalsController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
          Container(
            height: Get.height.h,
            width: Get.width.w,
            child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/backscreen.png',
                                  ),
                                  fit: BoxFit.cover))
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GetBuilder<PersonalinfoController>(
                                builder: (_PersonalinfoController) {
                                  return Container(
                                    width: Get.width,

                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.notifications_active_outlined),
                                            ),

                                            // InkWell(
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(Myaccount());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.menu_open_outlined),
                                              ),
                                            )
                                          ]),
                                    ),
                                  );
                                }),
                            GetBuilder<PersonalinfoController>(
                                builder: (_PersonalinfoController) {
                                  print("login_data_global name is ${login_data_global.student.name}");
                                  return Container(
                                    width: Get.width,

                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: Row(children: [

                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    authController.login_data.student.gender,
                                                    style: semibold.copyWith(
                                                        color: Colors.grey, height: 1),
                                                  ),
                                                  Text(
                                                    // _PersonalinfoController.name,
                                                    authController.login_data.student.name,
                                                    style: semibold.copyWith(
                                                        fontSize: 16.sp,
                                                        color: primcolor,
                                                        height: 2),
                                                  ),
                                                  Text(
                                                    // 'الأول المتوسط',
                                                      login_data_global.student.study_year,
                                                    style: semibold.copyWith(
                                                        color: Colors.grey, height: 1),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Obx(() => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10000),
                                            border: Border.all(width: 1, color: primcolor),
                                          ),
                                          child: ClipOval(
                                            child: FullScreenWidget(
                                              disposeLevel: DisposeLevel.Low,
                                              child: Hero(
                                                tag: "customTag",
                                                child: Image.network(
                                                  // authController.login_data.student.image,
                                                  authController.image_link.value,
                                                  width: 70.sp,
                                                  height: 70.sp,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ]),
                                    ),
                                  );
                                }),
                            Obx(() =>  Column(
                              children: [
                                Image.asset(
                                  'assets/homeappbare.png',
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                ),
                                medalsController.medalloded.value==true?
                                Padding(
                                  padding:  EdgeInsets.only(top: 10.0.h,bottom: 10.0.h,left: 10.0.w,right: 10.0.w),
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 10.0.w,
                                      mainAxisSpacing: 20.0.w,
                                    ),
                                    itemCount: medalsController.medals_length.value,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            if (medalsController
                                                .medals[index].selected !=
                                                '1') {
                                              Get.to(MedalDetails(
                                                  medalsController.medals[index]));
                                            } else {
                                              Get.to(MedalDetails2(
                                                  medalsController.medals[index]));
                                            }
                                          },
                                          child: Image.network( medalsController.medals[index].image.toString())
                                      );
                                    },
                                  ),
                                )
                                    :CircularProgressIndicator(),
                              ],
                            )),
                            SizedBox(
                              height: 70.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Get.offAll(LoginScreen());
          },
          child: Container(
            width: 200.w,
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(238, 194, 109, 1),
                      Color.fromRGBO(195, 151, 58, 1)
                    ])),
            child: Center(
              child: Text(
                'تسجيل الخروج',
                style: semibold.copyWith(color: Colors.white,fontSize: 16.sp),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
