import 'package:flutter/material.dart';

import '../../../core/resources/app_color.dart';

class RowOfOrder extends StatelessWidget {
  const RowOfOrder({
    super.key,
    required this.title1,
    required this.title2,
  });
  final String title1;

  final String title2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title1,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: AppColor.brown),
        ),
        Text(
          title2,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: AppColor.blodbrownText),
        ),
      ],
    );
  }
}
