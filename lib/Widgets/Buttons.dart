import 'package:flutter/material.dart';
import 'package:salateapp/globals.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget button1(String title, void f()) {
  return InkWell(
    onTap: f,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [primcolor.withOpacity(0.3), primcolor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Text(
        title,
        style: semibold.copyWith(color: Colors.white,fontSize: 12.sp),
      ),
    ),
  );
}
