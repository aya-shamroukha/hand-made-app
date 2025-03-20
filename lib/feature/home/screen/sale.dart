import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/app_color.dart';
import '../../share/sized_box.dart';

class Sale extends StatelessWidget {
  const Sale({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/d.jpg',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                  SizedBox_width(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' بازار في فندق الداما روز',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox_Height(height: 5.h),
                      Text(
                        '22/03/2025 -> 25/03/2025',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColor.brown.withOpacity(0.7),
                                fontSize: 17),
                      ),
                      SizedBox_Height(height: 5.h),
                      Text(
                        '12:00 -> 2:00 PM',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColor.brown.withOpacity(0.7),
                                fontSize: 17),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/f.jpg',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                  SizedBox_width(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' بازار في فندق الفورسيزون  ',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox_Height(height: 5.h),
                      Text(
                        '24/03/2025 -> 27/03/2025',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColor.brown.withOpacity(0.7),
                                fontSize: 17),
                      ),
                      SizedBox_Height(height: 5.h),
                      Text(
                        '2:00 -> 5:00 PM',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColor.brown.withOpacity(0.7),
                                fontSize: 17),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
