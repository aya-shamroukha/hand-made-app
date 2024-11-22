import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/custom_text_field.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                        )),
                  ),
                  SizedBox_Height(height: 60.h),
                  Image.asset(AppAssets.forgetPassword),
                  SizedBox_Height(height: 30.h),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      AppStrings.checkemailtext.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: AppColor.blodbrownText),
                    ),
                  ),
                  SizedBox_Height(height: 10.h),
                  CustomTextfield(labeltext: AppStrings.email.tr()),
                  SizedBox_Height(height: 130.h),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('checkcode');
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
