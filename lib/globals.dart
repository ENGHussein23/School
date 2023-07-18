import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salateapp/Models/login_model.dart';

// Login login_data_global=Login();

TextStyle semibold = TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp);

TextStyle hintstyle = TextStyle(color: Colors.grey[400]);
TextStyle normalstyle = TextStyle(color: Colors.black);
Color primcolor = Color.fromRGBO(0, 128, 255, 1);
Color seccolor = Colors.amber;

const API_URL="https://school.nourcheaito.com/api";
const Auth_URL="$API_URL/auth/login";
const API_Images_Url='https://school.nourcheaito.com/';
const No_Image_Available="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUDeQ0UC4TH-VQn1gDp7HjwAPQvHiQvYHezg&usqp=CAU";
const No_Image_Female="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRSON8LeVQSy-fWiS03zwhO6ZMgRqGFTbQHLN6wAEGhIxl3T18a";
const No_Imahe_Male="https://anubis.gr/wp-content/uploads/2018/03/no-avatar.png";
const API_Competetion_Index="/competetion/index";
const API_Update_Image="$API_URL/student/update-image";
const API_Competetion_Show="$API_URL/competetion/show/";
class MyCustomInput2 extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FormFieldValidator<String>? onshanged;
  final TextEditingController textEditingController;
  final String hint;

  Widget? preffix;
  Widget? suffix;
  TextInputType? keyboardType;
  bool? focus;
  bool? enable;

  MyCustomInput2({
    this.suffix,
    this.enable,
    this.onshanged,
    this.preffix,
    this.focus,
    this.keyboardType,
    required this.hint,
    required this.textEditingController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: Padding(
          padding:
               EdgeInsets.only(left: 12.w, right: 12.w, top: 8.0.h, bottom: 8.h),
          child: TextFormField(
            controller: textEditingController,
            validator: validator,
            onChanged: onshanged,
            enabled: enable ?? true,
            cursorColor: primcolor,
            style: normalstyle,
            autofocus: focus ?? false,
            keyboardType: keyboardType,
            decoration: InputDecoration(

              prefixIcon: preffix,
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              hintStyle: hintstyle,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              alignLabelWithHint: false,
              // label: Text(hint),

              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ));
  }
}
