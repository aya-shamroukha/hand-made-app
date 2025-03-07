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

class CheckCodeScreen extends StatelessWidget {
  CheckCodeScreen({super.key});
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          color: AppColor.primary,
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                            AppColor.primary,
                          )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColor.background,
                            size: 20,
                          ))),
                  SizedBox_Height(height: 60.h),
                  Image.asset(AppAssets.forgetPassword),
                  SizedBox_Height(height: 30.h),
                  // Padding(
                  //   padding: const EdgeInsets.all(6.0),
                  //   child: Text(
                  //     AppStrings.checkemailtext.tr(),
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .displaySmall!
                  //         .copyWith(color: AppColor.blodbrownText),
                  //   ),
                  // ),
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

                  SizedBox_Height(height: 130.h),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('newpassword');
                    },
                    text: AppStrings.send.tr(),
                    height: 40,
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
