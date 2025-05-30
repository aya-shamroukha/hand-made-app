import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import '../../share/positioned_for_icon.dart';
import '../../share/shimmer_body.dart';
import '../../share/sized_box.dart';
import '../bloc/auction_bloc/auction_state.dart';

class HandcraftByauctionScreen extends StatelessWidget {
  const HandcraftByauctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuctionBloc()
        ..add(GetHandCraftByAuctionSuccessEvent(
            id: getIt.get<SharedPreferences>().getInt('auctionId'))),
      child: SafeArea(
          child: Scaffold(
        floatingActionButton: Tooltip(
          //  textStyle: Theme.of(context).textTheme.displaySmall,
          message: AppStrings.makerauction.tr(),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('maker');
            },
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColor.primary),
              child: Icon(
                Icons.people_alt,
                color: AppColor.background,
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                AppStrings.productinauction.tr(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                color: AppColor.lightbrownText,
              ),
            ),
            BlocBuilder<AuctionBloc, AuctionState>(
              builder: (context, state) {
                if (state is GetHandCraftByAuctionSuccessState) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // childAspectRatio: 2 / 3,
                          ),
                          itemCount: state.model.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                getIt.get<SharedPreferences>().setInt(
                                    'id details', state.model[index].id);
                                Navigator.of(context)
                                    .pushNamed('categoriesdetails');
                              },
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getIt.get<SharedPreferences>().setInt(
                                          'id details', state.model[index].id);
                                      print(
                                          getIt.get<SharedPreferences>().getInt(
                                                'id details',
                                              ));
                                      Navigator.of(context)
                                          .pushNamed('categoriesdetails');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenWidth * 0.7,
                                        height: screenHeight * 0.13,
                                        decoration: BoxDecoration(
                                          color: AppColor.lightbrownText,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'http://199.192.19.220:5400/${state.model[index].handcraft_image}',
                                            width: screenWidth * 0.7,
                                            height: screenHeight * 0.02,
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (context, error, stackTrace) {
                                              if (stackTrace == null) {
                                                return Image.network(
                                                    width: screenWidth * 0.6,
                                                    height: screenHeight * 0.02,
                                                    fit: BoxFit.fill,
                                                    'http://199.192.19.220:5400/${state.model[index].handcraft_image}');
                                              } else {
                                                return Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: ShimmerBodyForImage(
                                                    width: screenWidth * 0.06,
                                                    height: screenHeight * 0.02,
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
                                                  height: screenHeight * 0.2.h,
                                                  width: screenWidth * 0.4.w,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox_Height(height: 10.h),
                                  Text(
                                    state.model[index].handcraft_name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 17),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    state.model[index].handcraft_price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            fontSize: 13,
                                            color: AppColor.blodbrownText),
                                    textAlign: TextAlign.start,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.model[index].maker.username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontSize: 13,
                                                color: AppColor.blodbrownText),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox_width(width: 3.w),
                                      Icon(
                                        Icons.person,
                                        color: AppColor.primary,
                                        size: 13,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SizedBox(
                      height: double.maxFinite,
                      width: 400,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // childAspectRatio: 2 / 3,
                          ),
                          itemCount: 6,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: ShimmerBodyForImage(
                                  height: screenHeight * 0.2.h,
                                  width: screenWidth * 0.4.w,
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
      )),
    );
  }
}
