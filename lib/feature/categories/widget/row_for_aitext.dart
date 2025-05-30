import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/app_color.dart';
import '../../share/sized_box.dart';

class RowForAiText extends StatelessWidget {
  const RowForAiText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'يمكنك المحاكاة من هنا :',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox_width(width: 10.w),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('ai');
          },
          child: Text(
            'محاكاة',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  // fontSize: 20,
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                  decorationColor: AppColor.primary,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }
}
