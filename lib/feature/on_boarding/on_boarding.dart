import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/domin/model/on_boarding_model.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/resources/app_color.dart';

// ignore: must_be_immutable
class OnBoaringScreens extends StatelessWidget {
  OnBoaringScreens({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColor.background,
        body: PageView.builder(
          controller: controller,
          itemCount: OnBoradingModel.onBoradingScreen.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    OnBoradingModel.onBoradingScreen[index].imagPath,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03.h,
                    ),
                    //!skip text
                    index != 2
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: Text(
                                AppStrings.skip.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: AppColor.blodbrownText,
                                        fontSize: 13.sp),
                              ),
                              onPressed: () {
                                controller.jumpToPage(2);
                              },
                            ),
                          )
                        : SizedBox(
                            height: screenHeight * 0.04.h,
                          ),

                    SizedBox(
                      height: screenHeight * 0.03.h,
                    ),

                    //!title
                    index == 1
                        ? Column(
                            children: [
                              SizedBox_Height(
                                height: screenHeight * 0.6,
                              ),
                              Text(
                                  textAlign: TextAlign.center,
                                  OnBoradingModel.onBoradingScreen[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 25.sp,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black
                                            .withOpacity(0.2), // Shadow color
                                        offset: const Offset(
                                            3, 6), // X and Y offset
                                        blurRadius: 2, // Blur radius
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                                OnBoradingModel.onBoradingScreen[index].title,
                                textAlign: index == 2
                                    ? TextAlign.left
                                    : TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                  fontWeight: FontWeight.normal,
                                  // color: AppColor.brownText,
                                  fontSize: 25.sp,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black
                                          .withOpacity(0.2), // Shadow color
                                      offset:
                                          const Offset(3, 6), // X and Y offset
                                      blurRadius: 2, // Blur radius
                                    ),
                                  ],
                                )),
                          ),

                    SizedBox(
                      height: 12.h,
                    ),

                    const Spacer(),
                    //!buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //!back button
                          index != 0
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: 40.h,
                                    width: 45.w,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColor.primary),
                                        color: AppColor.background,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back,
                                          color: AppColor.primary),
                                      onPressed: () {
                                        controller.previousPage(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          //!dots
                          SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: ExpandingDotsEffect(
                                activeDotColor: AppColor.primary,
                                dotHeight: 4,
                                spacing: 8),
                          ),
                          //! next Button

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 40.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward,
                                    color: AppColor.white),
                                onPressed: () async {
                                  index != 2
                                      ? controller.nextPage(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.fastLinearToSlowEaseIn)
                                      : await getIt
                                          .get<SharedPreferences>()
                                          .setBool('onboarding', true)
                                          .then((value) {
                                          Navigator.of(context)
                                              .pushReplacementNamed('login');
                                        });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ));
  }
}
