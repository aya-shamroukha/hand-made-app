import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/domin/model/auth_model/signup_model.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/auth/bloc/signup_bloc/sign_up_bloc.dart';
import 'package:hand_made_app/feature/auth/bloc/signup_bloc/sign_up_state.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/custom_text_field.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:hand_made_app/feature/share/toast.dart';

import '../../../core/resources/app_color.dart';
import '../bloc/signup_bloc/sign_up_event.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.of(context).pushReplacementNamed('bottom');
          } else if (state is SignUpFieldState) {
            showTost(
                message: AppStrings.signupFailed.tr(), state: ToastState.error);
          }
        },
        builder: (context, state) {
          var signupbloc = BlocProvider.of<SignUpBloc>(context);

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: signupbloc.formkey,
                  child: Column(children: [
                    // SizedBox_Height(height: 70.h),
                    Center(
                      child: Image.asset(
                        AppAssets.splash,
                        width: 300.w,
                        fit: BoxFit.cover,
                        height: 270.h,
                      ),
                    ),
                    // Center(
                    //   child: Text(
                    //     AppStrings.signup.tr(),
                    //     textAlign: TextAlign.center,
                    //     style: Theme.of(context).textTheme.displayLarge,
                    //   ),
                    // ),
                    // SizedBox_Height(height: 20.h),
                    // Text(
                    //   AppStrings.creataccounttitle.tr(),
                    //   textAlign: TextAlign.center,
                    //   style: Theme.of(context).textTheme.displayMedium!,
                    // ),
                    //  SizedBox_Height(height: 50.h),
                    //!username
                    CustomTextfield(
                      labeltext: AppStrings.userName.tr(),
                      controller: signupbloc.username,
                      validate: (val) {
                        if (val.isEmpty) {
                          return AppStrings.nameErrorMsg.tr();
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      textInputType: TextInputType.emailAddress,
                      labeltext: AppStrings.email.tr(),
                      controller: signupbloc.email,
                      validate: (val) {
                        if (val.isEmpty && !val.contains('@gmail.com')) {
                          return AppStrings.valiemail.tr();
                        }
                        return null;
                      },
                    ),
                    //!phone
                    CustomTextfield(
                      textInputType: TextInputType.number,
                      labeltext: AppStrings.phone.tr(),
                      controller: signupbloc.phone,
                    ),
                    //!password
                    CustomTextfield(
                      validate: (val) {
                        if (val!.length < 8) {
                          return AppStrings.passwordlenght.tr();
                        }
                        return null;
                      },
                      labeltext: AppStrings.password.tr(),
                      controller: signupbloc.password,
                      isScreat: signupbloc.isPassword,
                      suffixicon: IconButton(
                          onPressed: () {
                            context
                                .read<SignUpBloc>()
                                .add(PasswordEvent(signupbloc.isPassword));
                          },
                          icon: signupbloc.isPassword == true
                              ? Icon(
                                  Icons.visibility_off,
                                  color: AppColor.primary,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: AppColor.primary,
                                )),
                    ),
                    Row(
                      children: [
                        SizedBox_width(width: 20.w),
                        Text(
                          AppStrings.alreadyhaveaccount.tr(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('login');
                          },
                          child: Text(
                            AppStrings.login.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: AppColor.primary,
                                    textBaseline: TextBaseline.alphabetic),
                          ),
                        )
                      ],
                    ),
                    SizedBox_Height(height: 50.h),
                    Container(
                      height: 50.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary),
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        icon:
                            Icon(Icons.arrow_back, color: AppColor.background),
                        onPressed: () {},
                      ),
                    ),
                    // state is SignUpLoadingState
                    //     ? const Loading()
                    //     : CustomButton(
                    //         height: 35.h,
                    //         onPressed: () {
                    //           if (BlocProvider.of<SignUpBloc>(context)
                    //               .formkey
                    //               .currentState!
                    //               .validate()) {
                    //             context
                    //                 .read<SignUpBloc>()
                    //                 .add(SignUpSuccess(SignUpModel(
                    //                   name: 'aya',
                    //                   username: signupbloc.username.text,
                    //                   phone_number: signupbloc.phone.text,
                    //                   password: signupbloc.password.text,
                    //                   email: signupbloc.email.text,
                    //                 )));
                    //           } else {
                    //             showTost(
                    //                 message: AppStrings.signup.tr(),
                    //                 state: ToastState.error);
                    //           }
                    //         },
                    //         text: AppStrings.signup.tr(),
                    //       )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
