import 'package:flutter/material.dart';

import '../../../core/resources/app_color.dart';

class RowForText extends StatelessWidget {
  const RowForText({
    super.key,
    required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColor.brown.withOpacity(0.7), fontSize: 17),
        ),
      ],
    );
  }
}
