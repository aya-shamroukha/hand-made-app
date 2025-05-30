import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/domin/model/auth_model/reset_password_model.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_event.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_state.dart';
import 'package:hand_made_app/feature/share/custom_text_field.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/positioned_for_icon.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_string.dart';
import '../../share/custom_button.dart';
import '../../share/toast.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    TextEditingController newpassword = TextEditingController();

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is SendEmailSuccessState) {
          Navigator.of(context).pushNamed('login');
          showTost(
              message: AppStrings.checkYouremail.tr(),
              state: ToastState.success);
        } else if (state is SendEmailFieldState) {
          showTost(message: AppStrings.failed.tr(), state: ToastState.error);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19.0),
                        child: Text(
                          AppStrings.newpasswordtext.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: AppColor.brown),
                        ),
                      ),
                      SizedBox_Height(height: 10.h),
                      CustomTextfield(
                        controller: newpassword,
                        labeltext: AppStrings.password.tr(),
                        validate: (val) {
                          if (val.isEmpty && val == null) {
                            return AppStrings.passwordlenght.tr();
                          }

                          return null;
                        },
                      ),
                      SizedBox_Height(height: screenHeight * 0.07),
                      state is SendNewPasswordLoadingState
                          ? const Loading()
                          : Center(
                              child: CustomButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    context.read<ResetPasswordBloc>().add(
                                        SendNewPasswordEvent(SendPasswordModel(
                                            email: getIt
                                                .get<SharedPreferences>()
                                                .getString('email')
                                                .toString(),
                                            new_password:
                                                newpassword.text.toString())));
                                  }
                                },
                                text: AppStrings.change.tr(),
                              ),
                            )
                    ],
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
