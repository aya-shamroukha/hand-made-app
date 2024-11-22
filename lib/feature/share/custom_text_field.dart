import 'package:flutter/material.dart';

import '../../core/resources/app_color.dart';

class CustomTextfield extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomTextfield({
    super.key,
    this.validate,
    required this.labeltext,
    this.controller,
    this.suffixicon,
    this.isScreat = false,
    this.prefixIcon,
    this.textInputType,
  });

  final String labeltext;
  final TextEditingController? controller;
  final dynamic validate;
  final IconButton? suffixicon;
  final Icon? prefixIcon;
  final bool isScreat;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: Theme.of(context).textTheme.displaySmall!,
          keyboardType: textInputType,
          validator: validate,
          obscureText: isScreat,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          cursorColor: AppColor.primary,
          decoration: InputDecoration(
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              focusedBorder:
                  Theme.of(context).inputDecorationTheme.focusedBorder,
              enabledBorder:
                  Theme.of(context).inputDecorationTheme.enabledBorder,
              hintText: labeltext,
              prefixIcon: prefixIcon,
              suffixIcon: suffixicon),
        ),
      );
    });
  }
}
