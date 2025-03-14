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
import 'package:hand_made_app/feature/share/toast.dart';

import '../../../core/resources/app_color.dart';
import '../bloc/signup_bloc/sign_up_event.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

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
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: Image.asset(
                        AppAssets.splash,
                        width: screenWidth * 0.6,
                        fit: BoxFit.cover,
                        height: screenHeight * 0.3,
                      ),
                    ),
                    //  SizedBox(height: screenHeight * 0.05),
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
                    CustomTextfield(
                      textInputType: TextInputType.number,
                      labeltext: AppStrings.phone.tr(),
                      controller: signupbloc.phone,
                    ),
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
                    SizedBox(height: screenHeight * 0.1),
                    state is SignUpLoadingState
                        ? const Loading()
                        : CustomButton(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.4,
                            onPressed: () {
                              if (BlocProvider.of<SignUpBloc>(context)
                                  .formkey
                                  .currentState!
                                  .validate()) {
                                context
                                    .read<SignUpBloc>()
                                    .add(SignUpSuccess(SignUpModel(
                                      username: signupbloc.username.text,
                                      phone_number: signupbloc.phone.text,
                                      password: signupbloc.password.text,
                                      email: signupbloc.email.text,
                                    )));
                              } else {
                                showTost(
                                    message: AppStrings.signup.tr(),
                                    state: ToastState.error);
                              }
                            },
                            text: AppStrings.signup.tr(),
                          ),
                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      children: [
                        SizedBox(width: screenWidth * 0.05),
                        Text(
                          AppStrings.alreadyhaveaccount.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 13.sp,
                                  color: AppColor.blodbrownText),
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
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColor.primary,
                                    fontSize: 13.sp),
                          ),
                        )
                      ],
                    ),
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
