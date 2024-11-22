import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/domin/model/on_boarding_model.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/resources/app_color.dart';

// ignore: must_be_immutable
class OnBoaringScreens extends StatelessWidget {
  OnBoaringScreens({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.background,
          body: Padding(
            padding: const EdgeInsets.all(14),
            child: PageView.builder(
              controller: controller,
              itemCount: OnBoradingModel.onBoradingScreen.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
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
                                        color: AppColor.secondary,
                                        fontSize: 20),
                              ),
                              onPressed: () {
                                controller.jumpToPage(2);
                              },
                            ),
                          )
                        : SizedBox(
                            height: 46.h,
                          ),

                    //!image
                    Image.asset(
                      OnBoradingModel.onBoradingScreen[index].imagPath,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),

                    //!dots
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          activeDotColor: AppColor.primary,
                          dotHeight: 4,
                          spacing: 8),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    //!title
                    Text(OnBoradingModel.onBoradingScreen[index].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.normal, fontSize: 25)),
                    SizedBox(
                      height: 12.h,
                    ),

                    //!subTitle
                    Text(OnBoradingModel.onBoradingScreen[index].subtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 20)),
                    const Spacer(),
                    //!buttons
                    Row(
                      children: [
                        //!back button
                        index != 0
                            ? Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 50.h,
                                  width: 55.w,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColor.primary),
                                      color: AppColor.background,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back,
                                        color: AppColor.primary),
                                    onPressed: () {
                                      controller.previousPage(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        //spacer
                        const Spacer(),
                        //! next Button

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 50.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward,
                                  color: AppColor.white),
                              onPressed: () async {
                                index != 2
                                    ? controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 1000),
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
                    )
                  ],
                );
              },
            ),
          )),
    );
  }
}
