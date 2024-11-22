import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_font.dart';

ThemeData appTheme = ThemeData(
    //brightness: Brightness.dark,
    primaryColor: AppColor.primary,

//  appBarTheme:  AppBarTheme(
//   backgroundColor: AppColor.background,
//   centerTitle: false,

//  iconTheme: IconThemeData(color: AppColor.white),
//   titleTextStyle:
//   TextStyle(fontSize: 24,color: AppColor.textColor,fontWeight: FontWeight.normal),
// elevation: 0,

//   ),
    // floatingActionButtonTheme:  FloatingActionButtonThemeData(
    //   shape: CircleBorder(),
    //   backgroundColor: AppColor.primary),
    scaffoldBackgroundColor: AppColor.background,
    drawerTheme: DrawerThemeData(backgroundColor: AppColor.background),
    textTheme: TextTheme(
      displayLarge: boldStyle(),
      displayMedium: normalStyle(),
      displaySmall: smallStyle(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          textStyle: TextStyle(color: AppColor.white, fontSize: 30.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      labelStyle: TextStyle(fontSize: 15.sp, color: AppColor.brownText),
      fillColor: AppColor.background,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primary)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primary)),
      hintStyle: TextStyle(fontSize: 15.sp, color: AppColor.brownText),
    ));
