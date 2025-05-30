import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';

import '../../../core/resources/app_color.dart';

class RowOfOrder extends StatelessWidget {
  const RowOfOrder({
    super.key,
    required this.title1,
    required this.title2,
    this.textStyle,
  });
  final String title1;

  final String title2;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title1,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: AppColor.brown, fontSize: 15.sp),
        ),
        SizedBox_width(width: 5.w),
        Text(
          title2,
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: AppColor.blodbrownText, fontSize: 13.sp),
        ),
      ],
    );
  }
}
