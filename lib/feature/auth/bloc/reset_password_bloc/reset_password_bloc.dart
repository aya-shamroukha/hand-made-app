import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domin/service/auth_service.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  TextEditingController email = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // GlobalKey<FormState> keycode = GlobalKey<FormState>();

  // GlobalKey<FormState> keypassword = GlobalKey<FormState>();

  TextEditingController code = TextEditingController();
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<SendEmailEvent>((event, emit) async {
      emit(SendEmailLoadingState());
      try {
        final isSuccess =
            await AuthServiceImpl().sendEmail(event.sendEmailModel);
        print('----------------');
        print(isSuccess);
        if (isSuccess) {
          emit(SendEmailSuccessState());
        }
      } catch (e) {
         print(e.toString());
        emit(SendEmailFieldState());
      }
    });

    //!code
    on<SendCodeEvent>((event, emit) async {
      emit(SendCodeLoadingState());
      try {
        final isSuccess = await AuthServiceImpl().sendCode(event.sendCodeModel);
        print('----------------');
        print(isSuccess);
        if (isSuccess) {
          emit(SendCodeSuccessState());
        }
      } catch (e) {
        print(e);
        emit(SendCodeFieldState());
      }
    });
    //!newpassword
    on<SendNewPasswordEvent>((event, emit) async {
      emit(SendNewPasswordLoadingState());
      try {
        final isSuccess =
            await AuthServiceImpl().sendPassword(event.sendPasswordModel);
        print('----------------');
        print(isSuccess);
        if (isSuccess) {
          emit(SendNewPasswordSuccessState());
        }
      } catch (e) {
        print(e);
        emit(SendNewPasswordSuccessState());
      }
    });
  }
}
