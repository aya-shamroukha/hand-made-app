import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../share/shimmer_body.dart';
import '../../share/sized_box.dart';
import '../bloc/auction_bloc/auction_state.dart';
import '../widget/row_for_textandicon.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.shoppingPag,
                    width: screenWidth * 0.13,
                  ),
                  SizedBox_width(width: 7.w),
                  Text(
                    AppStrings.auction.tr(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  color: AppColor.lightbrownText,
                ),
              ),
              BlocBuilder<AuctionBloc, AuctionState>(
                builder: (context, state) {
                  if (state is GetAuctionSuccessState) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: state.model.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox_width(width: 10.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getIt.get<SharedPreferences>().setInt(
                                              'auctionId',
                                              state.model[index].id);
                                          Navigator.of(context)
                                              .pushNamed('handauction');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: screenHeight * 0.17,
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                              color: AppColor.lightbrownText
                                                  .withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.model[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              SizedBox_Height(height: 5.h),
                                              Text(
                                                state.model[index].description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        color: AppColor.brown
                                                            .withOpacity(0.7),
                                                        fontSize: 17),
                                              ),
                                              SizedBox_Height(height: 5.h),
                                              RowForIconAndText(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        color: AppColor.brown
                                                            .withOpacity(0.7),
                                                        fontSize: 17,
                                                        overflow:
                                                            TextOverflow.clip),
                                                text:
                                                    state.model[index].location,
                                                icon:
                                                    Icons.location_on_outlined,
                                              ),
                                              SizedBox_Height(height: 5.h),
                                              RowForIconAndText(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        color: AppColor.brown
                                                            .withOpacity(0.7),
                                                        fontSize: 17,
                                                        overflow:
                                                            TextOverflow.clip),
                                                text: state
                                                    .model[index].from_date,
                                                icon: Icons.access_time,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
