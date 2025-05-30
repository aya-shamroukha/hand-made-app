// ignore_for_file: avoid_print, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/domin/model/auth_model/reset_password_model.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_event.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../share/positioned_for_icon.dart';
import '../../share/toast.dart';
import '../bloc/reset_password_bloc/reset_password_state.dart';

class CheckCodeScreen extends StatelessWidget {
  CheckCodeScreen({super.key});
  final TextEditingController _pinController = TextEditingController();
  GlobalKey<FormState> keycode = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is SendCodeSuccessState) {
          Navigator.of(context).pushNamed('newpassword');
        } else if (state is SendCodeFieldState) {
          showTost(message: AppStrings.failed.tr(), state: ToastState.error);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: keycode,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
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
                        SizedBox_Height(height: screenHeight * 0.06.h),
                        Image.asset(AppAssets.forgetPassword),
                        SizedBox_Height(height: screenHeight * 0.04.h),
                        Center(
                          child: Pinput(
                            controller: _pinController,
                            validator: (val) {
                              if (val!.length < 6 || val.isEmpty) {
                                return 'enter Your code';
                              } else {
                                return '';
                              }
                            },
                            length: 6, // Number of input fields
                            onCompleted: (pin) {
                              // Handle the completed PIN
                              print('---------------');
                              print('PIN entered: $pin');
                            },
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: AppColor.brown,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.primary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox_Height(height: screenHeight * 0.07),
                        state is SendCodeLoadingState
                            ? const Loading()
                            : Center(
                                child: CustomButton(
                                  onPressed: () {
                                    if (keycode.currentState!.validate()) {
                                      context.read<ResetPasswordBloc>().add(
                                          SendCodeEvent(
                                              sendCodeModel: SendCodeModel(
                                                  code: _pinController.text
                                                      .toString(),
                                                  email: getIt
                                                      .get<SharedPreferences>()
                                                      .getString('email')
                                                      .toString())));
                                    }
                                    Navigator.of(context)
                                        .pushNamed('newpassword');
                                    print(_pinController.text);
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
          ),
        );
      },
    );
  }
}
