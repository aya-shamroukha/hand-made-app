// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/service/auth_service.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPassword = true;
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSuccess>((event, emit) async {
      emit(SignUpLoadingState());
      final isSuccess = await AuthServiceImpl().signUp(event.signUpModel);
      print(isSuccess);
      if (isSuccess.isRight()) {
        emit(SignUpSuccessState());
      } else {
        emit(SignUpFieldState());
      }
    });
    on<PasswordEvent>(
      (event, emit) {
        isPassword = !isPassword;
        emit(PasswordState());
      },
    );
  }
}
