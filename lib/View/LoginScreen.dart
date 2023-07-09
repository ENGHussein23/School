import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widgets/Buttons.dart';
import '../globals.dart';
import 'Home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController passC = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: Get.width,
                height: Get.height - Get.statusBarHeight / 2,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/uppbar.png',
                      fit: BoxFit.cover,
                      width: Get.width,
                    ),
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyCustomInput2(
                                validator: (f) {},
                                preffix: Icon(Icons.person_2_outlined),
                                hint: 'رقم الجوال',
                                textEditingController: numbercontroller,
                              ),
                              MyCustomInput2(
                                preffix: Icon(Icons.key_rounded),
                                validator: (f) {},
                                hint: 'كلمة المرور',
                                textEditingController: passC,
                              ),
                              Padding(
                                padding:  EdgeInsets.all(12.0.w),
                                child: Center(child: button1('تسجيل الدخول', () {
                                  authController.login(numbercontroller.text, passC.text);
                                  // Get.to(HomeScreen());
                                }),)
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     // InkWell(
                                //     //   child: Text(
                                //     //     'نسيت كلمة المرور ؟',
                                //     //     style: semibold,
                                //     //   ),
                                //     // ),
                                //     button1('تسجيل الدخول', () {
                                //       authController.login(numbercontroller.text, passC.text);
                                //       // Get.to(HomeScreen());
                                //     }),
                                //   ],
                                // ),
                              )
                            ],
                          ),
                        )),
                    Image.asset(
                      'assets/bottom.png',
                      fit: BoxFit.cover,
                      width: Get.width,
                    )
                  ],
                )),
            Obx(() {
              return Visibility(
                  visible: authController.is_loading_login.value==true,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black45
                    ),
                    width: Get.width,
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ));
            })
          ],
        )
       ,
      )),
    );
  }
}
