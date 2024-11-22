// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height = 40,
    this.width = 340,
    required this.onPressed,
    this.background,
    required this.text,
    this.textcolor,
    this.shape,
  });
  final double? height;
  final double? width;
  final VoidCallback onPressed;
  final Color? background;
  final String text;
  final Color? textcolor;
  final dynamic shape;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height!.h,
      width: width!.w,
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            )),
            backgroundColor:
                WidgetStateProperty.all(background ?? AppColor.primary)),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: textcolor ?? Colors.white, fontSize: 18),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
