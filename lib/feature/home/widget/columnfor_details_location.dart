import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';

import '../../share/sized_box.dart';

class ColumnForDetailsLocation extends StatelessWidget {
  const ColumnForDetailsLocation({
    super.key,
    required this.controller,
    required this.text,
    required this.hint,
    this.validator,
  });

  final TextEditingController controller;
  final String text;
  final String hint;
  final dynamic? validator;
  //final double height;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textAlign: TextAlign.start,
          text,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox_Height(height: 5.h),
        Container(
          width: screenWidth * 0.9,
          //  height: screenHeight * 0.06,
          decoration: BoxDecoration(
              color: AppColor.lightbrownText.withOpacity(0.6),
              border: Border.all(color: AppColor.lightbrownText),
              borderRadius: BorderRadius.circular(30)),
          child: SizedBox(
            //    width: screenWidth * 0.9,
            //   height: screenHeight * 0.06,
            child: TextFormField(
              textAlign: TextAlign.start,
              // key: globalKey,
              validator: validator,
              cursorColor: AppColor.primary,
              maxLines: null, keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: hint,
                  filled: false),
              controller: controller,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ],
    );
  }
}
