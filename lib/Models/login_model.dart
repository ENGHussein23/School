import 'package:salateapp/globals.dart';

class Login{
  late String access_token;
  late Student student;
  late String token_type;
  late int expires_in;
  Login();
  Login.fromJson(Map<String,dynamic> json){
    access_token= json['access_token'];
    student=Student.fromJson(json['student']);
    token_type=json['token_type'];
    expires_in=json['expires_in'];
  }
}

class Student{
  late int id;
  late String name;
  late String birth_date;
  late String school_name;
  late String school_stage;
  late String phone;
  late String parents_name;
  late String study_year;
  late String email;
  late String blood_group;
  late String financial_id;
  late String image;
  late String gender;
Student();
  Student.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name']??"لم يتم تسجيل الاسم";
    birth_date=json['birth_date']??"لم يتم تسجيل تاريخ الميلاد";
    school_name=json['school_name']??"لم يتم تسجيل اسم المدرسة";
    school_stage=json['school_stage']??"لم يتم تسجيل المرحلة الدراسية";
    phone=json['phone']??"لم يتم تسجيل رقم الهاتف";
    parents_name=json['parents_name']??"لم يتم تسجيل اسم ولي الأمر";
    study_year=json['study_year']??"لم يتم تسجيل السنة الدراسية";
    email=json['email']??"لم يتم تسجيل الايميل";
    blood_group=json['blood_group']??"لم يتم تسجيل زمرة الدم";
    financial_id=json['financial_id']??"لم يتم التسجيل";
    image=json['image']==null? json['gender']=="female"?No_Image_Female:No_Imahe_Male :API_Images_Url+json['image'];
    gender=json['gender']=="female"?"البطلة":"البطل";
  }
}