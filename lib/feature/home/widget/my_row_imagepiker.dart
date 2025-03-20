import 'package:flutter/material.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:hand_made_app/feature/home/widget/dialog_for_image.dart';

class CoustomRow extends StatelessWidget {
  const CoustomRow({
    super.key,
    required this.icon,
    required this.string,
    this.ontap,
  });
  final IconData icon;
  final String string;

  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Call the original ontap if provided
        if (ontap != null) {
          ontap!();
        }
        // Show confirmation dialog after image selection
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogForImage(
              screenHeight: MediaQuery.of(context).size.height,
              selectedImage: 'path_to_selected_image', // Pass the selected image path here
            );
          },

        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.primary,
              size: 20.sp,
            ),
            SizedBox_width(
              width: 15.w,
            ),
            Text(string,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor.blodbrownText)),
          ],
        ),
      ),
    );
  }
}
