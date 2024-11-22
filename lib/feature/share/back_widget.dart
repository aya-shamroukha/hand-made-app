import 'package:flutter/material.dart';
import 'package:hand_made_app/core/resources/app_color.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: AppColor.primary,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
          AppColor.primary,
        )),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: AppColor.background,
          size: 20,
        ));
  }
}
