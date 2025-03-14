import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/home/widget/categories_card.dart';
import 'package:hand_made_app/feature/share/positioned_for_icon.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/local_storage/shared_preferences.dart';

class CategoriesById extends StatelessWidget {
  const CategoriesById({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox_width(
              width: 100.w,
            ),
            PositionedForIcon(top: screenHeight * 0.04),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('categoriesdetails');
                        },
                        child: Card(
                          color: AppColor.lightbrownText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: Image.asset(
                            'assets/images/v.png',
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.2,
                          ),
                        ),
                      ),
                      Text(
                        ' categories[index]',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ' price',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 17),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    )));
  }
}
