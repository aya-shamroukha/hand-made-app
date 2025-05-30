import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_made_app/core/resources/app_color.dart';

showTost({required String message, required ToastState state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getState(state),
      textColor: AppColor.background,
      fontSize: 16.0);
}

enum ToastState { error, success, warining }

Color getState(ToastState state) {
  switch (state) {
    case ToastState.error:
      return AppColor.red;
    case ToastState.success:
      return AppColor.primary;
    case ToastState.warining:
      return AppColor.secondary;
  }
}
