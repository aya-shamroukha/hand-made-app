// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_string.dart';

import '../../../core/resources/app_color.dart';

class BottomSheetForComment extends StatelessWidget {
  const BottomSheetForComment({
    super.key,
    required this.text,
    required this.id,
    required this.onPressed,
    required this.onPressedupdate, required this.controller,
  });
  final String text;
  final int id;
  final VoidCallback onPressed;
  final VoidCallback onPressedupdate;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.edit,
              color: AppColor.primary,
              size: 20,
            ),
            title: Text(
              AppStrings.update.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            onTap: () {
              //Navigator.pop(context);
              //final textController = TextEditingController(text: text);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColor.background,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Edit your comment',
                            border: OutlineInputBorder(),
                          ),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                AppStrings.cancel.tr(),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            TextButton(
                              onPressed: onPressedupdate,
                              child: Text(
                                AppStrings.update.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        decorationColor: AppColor.primary,
                                        decoration: TextDecoration.underline,
                                        color: AppColor.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: AppColor.lightbrownText,
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.delete,
                color: AppColor.primary,
                size: 17,
              ),
              title: Text(
                AppStrings.delete.tr(),
                style: Theme.of(context).textTheme.displaySmall!,
              ),
              onTap: onPressed),
        ],
      ),
    );
  }
}
