// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:pinput/pinput.dart';

import '../../share/positioned_for_icon.dart';

class CheckCodeScreen extends StatelessWidget {
  CheckCodeScreen({super.key});
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox_width(
                        width: 100.w,
                      ),
                      PositionedForIcon(top: screenHeight * 0.04),
                    ],
                  ),
                  SizedBox_Height(height: 60.h),
                  Image.asset(AppAssets.forgetPassword),
                  SizedBox_Height(height: 30.h),
                  SizedBox_Height(height: 10.h),
                  Center(
                    child: Pinput(
                      controller: _pinController,
                      length: 4, // Number of input fields
                      onCompleted: (pin) {
                        // Handle the completed PIN
                        print('---------------');
                        print('PIN entered: $pin');
                      },
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox_Height(height: screenHeight * 0.07),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('newpassword');
                      },
                      text: AppStrings.send.tr(),
                      width: screenWidth * 0.3,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
