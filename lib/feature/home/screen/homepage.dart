import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_categories_bloc/get_categories_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_categories_bloc/get_categories_event.dart';
import 'package:hand_made_app/feature/home/bloc/discount_bloc/discount_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/discount_bloc/discount_event.dart';
import 'package:hand_made_app/feature/home/bloc/discount_bloc/discount_state.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../categories/bloc/get_categories/get_categories_bloc/get_categories_state.dart';
import '../../share/shimmer_body.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late final PageController _pageController;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    //  _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(dynamic length) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // Check if PageController is attached
        if (_pageController.page == length - 1) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GetCategoriesBloc()..add(GetCategoriesSuccessEvent()),
          ),
          BlocProvider(
            create: (context) => DiscountBloc()..add(GetAllDiscountEvent()),
          ),
        ],
        child: SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              SizedBox_Height(height: screenHeight * 0.03),
              BlocBuilder<DiscountBloc, DiscountState>(
                builder: (context, state) {
                  if (state is GetAllDiscountSuccessState) {
                    _startAutoScroll(state.discount.length);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('discount');
                              },
                              child: Expanded(
                                child: SizedBox(
                                  width: screenWidth * 0.97,
                                  height: screenHeight * 0.17,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        controller: _pageController,
                                        itemCount: state.discount.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                                width: screenWidth * 0.97,
                                                height: screenHeight * 0.17,
                                                // margin:
                                                //     const EdgeInsets.symmetric(
                                                //         vertical: 5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColor.lightbrownText,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color:
                                                          AppColor.brownText),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            state
                                                                .discount[index]
                                                                .name,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          Text(
                                                            '${state.discount[index].precentage} %'
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .brown
                                                                        .withOpacity(
                                                                            0.7)),
                                                          ),
                                                          Text(
                                                            state
                                                                .discount[index]
                                                                .from_date,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    color: AppColor
                                                                        .brown
                                                                        .withOpacity(
                                                                            0.7)),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_downward,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                          Text(
                                                            state
                                                                .discount[index]
                                                                .to_date,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    color: AppColor
                                                                        .brown
                                                                        .withOpacity(
                                                                            0.7)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox_width(
                                                        width:
                                                            screenWidth * 0.05),
                                                    // Image.asset(
                                                    //   'assets/images/discounts.png',
                                                    //   fit: BoxFit.fitWidth,
                                                    //   width: 200,
                                                    //   height: 300,
                                                    // ),
                                                  ],
                                                )),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        left: getIt
                                                    .get<SharedPreferences>()
                                                    .getString(
                                                        'languagecode') ==
                                                'ar'
                                            ? 0 // Position on left for Arabic
                                            : null, // Null for English
                                        right: getIt
                                                    .get<SharedPreferences>()
                                                    .getString(
                                                        'languagecode') ==
                                                'ar'
                                            ? null // Null for Arabic
                                            : 0, // Position on right for English
                                        top: -3,
                                        child: Image.asset(
                                          'assets/images/coupon.png',
                                          fit: BoxFit.fill,
                                          width: screenWidth * 0.45,
                                          height: screenHeight * 0.18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox_Height(height: screenHeight * 0.01),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: state.discount.length,
                          effect: WormEffect(
                            activeDotColor: AppColor.primary,
                            dotColor: AppColor.brownText.withOpacity(0.5),
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(
                      width: screenWidth * 0.97,
                      height: screenHeight * 0.17,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShimmerBodyForImage(
                            height: screenHeight * 0.17,
                            width: screenWidth * 0.8,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                builder: (context, state) {
                  if (state is GetCategoriesSuccessState) {
                    return SizedBox(
                      height: screenHeight * 0.66,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: state.getCategories.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                getIt.get<SharedPreferences>().setInt(
                                    'id', state.getCategories[index].id);
                                Navigator.of(context)
                                    .pushNamed('categoriesbyid');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 27, vertical: 10),
                                child: Container(
                                  height: screenHeight * 0.17,
                                  width: screenWidth * 0.78,
                                  decoration: BoxDecoration(
                                      color: AppColor.lightbrownText
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColor.brownText)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.getCategories[index]
                                                  .category_name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            ),
                                            Container(
                                              width: screenWidth * 0.55,
                                              // height: screenHeight * 0.1,
                                              child: Text(
                                                // Remove maxLines and overflow to show full description
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                state.getCategories[index]
                                                    .category_description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: AppColor.brown
                                                            .withOpacity(0.7),
                                                        fontSize: 13.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox_width(width: 10.w),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.network(
                                            'http://199.192.19.220:5400/${state.getCategories[index].categorye_image}',
                                            width: screenWidth * 0.2,
                                            height: screenHeight * 1,
                                            fit: BoxFit.fitWidth,
                                            loadingBuilder:
                                                (context, error, stackTrace) {
                                              if (stackTrace == null) {
                                                return Image.network(
                                                    width: screenWidth * 0.2,
                                                    height: screenHeight * 1,
                                                    fit: BoxFit.fitWidth,
                                                    'http://199.192.19.220:5400/${state.getCategories[index].categorye_image}');
                                              } else {
                                                return Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: ShimmerBodyForImage(
                                                    width: screenWidth * 0.2,
                                                    height: screenHeight * 1,
                                                  ),
                                                );
                                              }
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                child: ShimmerBodyForImage(
                                                  width: screenWidth * 0.2,
                                                  height: screenHeight * 1,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: SizedBox(
                        height: double.maxFinite,
                        width: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerBodyForImage(
                                    height: screenHeight * 0.17,
                                    width: screenWidth * 0.8,
                                  ),
                                ),
                              );
                            })),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        )));
  }
}
   // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Icon(
                    //         Icons.location_on,
                    //         color: AppColor.primary,
                    //         size: 30,
                    //       ),
                    // Text(
                    //   getIt.get<SharedPreferences>().getString('address') == null
                    //       ? 'My location'
                    //       : '//${getIt.get<SharedPreferences>().getString('address')}',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(color: AppColor.blodbrownText),
                    // ),
                    //     ],
                    //   ),
                    // ),