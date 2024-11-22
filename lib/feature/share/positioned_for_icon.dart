import 'package:flutter/material.dart';

import '../../core/resources/app_color.dart';

class PositionedForIcon extends StatelessWidget {
  const PositionedForIcon({
    super.key,
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.icon,
    this.onPressed,
  });
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final IconData icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            color: AppColor.blodbrownText,
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
              AppColor.blodbrownText,
            )),
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: AppColor.background,
              size: 20,
            )),
      ),
    );
  }
}
