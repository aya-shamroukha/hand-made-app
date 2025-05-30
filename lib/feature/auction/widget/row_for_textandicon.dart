import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';

import '../../../core/resources/app_color.dart';

class RowForIconAndText extends StatelessWidget {
  const RowForIconAndText({
    super.key,
    required this.text,
    required this.icon,
    required this.textStyle,
  });
  final String text;
  final IconData icon;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.primary,
          size: 20,
        ),
        SizedBox_width(width: 5.w),
        Text(text,
            //overflow: TextOverflow.visible,
            style: textStyle)
      ],
    );
  }
}
