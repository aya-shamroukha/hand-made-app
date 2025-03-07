import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/domin/model/auth_model/login_model.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/auth/bloc/login_bloc/log_in_bloc.dart';
import 'package:hand_made_app/feature/auth/bloc/login_bloc/log_in_state.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/custom_text_field.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:hand_made_app/feature/share/toast.dart';

import '../../share/my_loading.dart';
import '../bloc/login_bloc/log_in_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInBloc(),
      child: BlocConsumer<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state is LogInSuccessState) {
            Navigator.of(context).pushReplacementNamed('bottom');
          } else if (state is LogInFieldState) {
            showTost(
                message: AppStrings.loginFailed.tr(), state: ToastState.error);
          }
        },
        builder: (context, state) {
          var loginbloc = BlocProvider.of<LogInBloc>(context);

          return Form(
            key: loginbloc.formkey,
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            AppAssets.splash,
                            width: 300.w,
                            fit: BoxFit.cover,
                            height: 270.h,
                          ),
                        ),
                        // SizedBox_Height(height: 20.h),
                        // Center(
                        //   child: Text(AppStrings.login.tr(),
                        //       style: Theme.of(context).textTheme.displayLarge!),
                        // ),
                        // SizedBox_Height(height: 20.h),
                        Row(
                          children: [
                            SizedBox_width(width: 10.w),
                            SizedBox(
                              width: 330.w,
                              child: Text(AppStrings.logintitle.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!),
                            ),
                          ],
                        ),
                        SizedBox_Height(height: 20.h),

                        CustomTextfield(
                          textInputType: TextInputType.emailAddress,
                          labeltext: AppStrings.userName.tr(),
                          controller: loginbloc.username,
                          validate: (val) {
                            if (val.isEmpty && !val.contains('@gmail.com')) {
                              return AppStrings.nameErrorMsg;
                            }
                            return null;
                          },
                        ),

                        //!password
                        CustomTextfield(
                          //  validate: (val) {
                          //   if (val!.length < 8) {
                          //     return AppStrings.passwordlenght.tr();
                          //   }

                          //   return null;
                          // },
                          labeltext: AppStrings.password.tr(),
                          controller: loginbloc.password,
                          isScreat: loginbloc.isPassword,
                          suffixicon: IconButton(
                              onPressed: () {
                                context
                                    .read<LogInBloc>()
                                    .add(PasswordEvent(loginbloc.isPassword));
                              },
                              icon: loginbloc.isPassword == true
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: AppColor.primary,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: AppColor.primary,
                                    )),
                        ),
                        SizedBox_Height(height: 10.h),
                        Row(
                          children: [
                            SizedBox_width(width: 10.w),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('forgetpassword');
                              },
                              child: Text(
                                AppStrings.forgetPassword.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox_width(width: 10.w),
                            Text(
                              AppStrings.donthaveaccount.tr(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('signup');
                              },
                              child: Text(
                                AppStrings.signup.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: AppColor.primary,
                                        textBaseline: TextBaseline.alphabetic),
                              ),
                            )
                          ],
                        ),
                        SizedBox_Height(height: 90.h),
                        // state is LogInLoadingState
                        //     ? const Loading()
                        //     :
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('bottom');
                            },
                            //   if (BlocProvider.of<LogInBloc>(context)
                            //       .formkey
                            //       .currentState!
                            //       .validate()) {
                            //     context
                            //         .read<LogInBloc>()
                            //         .add(LogInSuccess(LogInModel(
                            //           username: loginbloc.username.text,
                            //           password: loginbloc.password.text,
                            //         )));
                            //   } else {
                            //     showTost(
                            //         message: AppStrings.loginFailed.tr(),
                            //         state: ToastState.error);
                            //   }
                            // },
                            text: AppStrings.login.tr(),
                            height: 40,
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
      ),
    );
  }
}
