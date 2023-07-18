import 'dart:convert';
import 'dart:io';
import 'package:salateapp/Models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salateapp/Controller/auth_controller.dart';
import 'Controller/Bindingcontrollers.dart';
import 'View/Splashhscreen.dart';

late SharedPreferences sharedpref;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref=await SharedPreferences.getInstance();
  Get.put(AuthController());
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? token = sharedpref.getString('token');
    String? LoginJson = sharedpref.getString('user');
    String? ImageJson = sharedpref.getString('image');
    final AuthC=Get.put(AuthController());
    late String home;
    if (token == null) {
      // Token is null, navigate to login screen
      home = '0';
    } else {
      // Token is not null, navigate to home screen
      AuthC.login_data=Login.fromJson(jsonDecode(LoginJson!));
      AuthC.login_data.student.image=ImageJson!;
      AuthC.image_link.value=ImageJson;
      home = '1';
    }
    return ScreenUtilInit(
        designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, snapshot) {
        return GetMaterialApp(
          title: 'تطبيق المدرسة',
          debugShowCheckedModeBanner: false,
          locale: Locale('ar'),
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),
          initialBinding: InitialBinding(),
          home: Splashhscreen(home),
        );
      }
    );
  }
}
