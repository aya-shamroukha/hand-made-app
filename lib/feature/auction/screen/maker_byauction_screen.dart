import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_event.dart';
import 'package:hand_made_app/feature/share/shimmer_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../share/positioned_for_icon.dart';
import '../../share/sized_box.dart';
import '../bloc/auction_bloc/auction_state.dart';
import '../widget/row_for_textandicon.dart';

class MakerByAuctionScreen extends StatelessWidget {
  const MakerByAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuctionBloc()
        ..add(GetMakerByAuctionSuccessEvent(
            id: getIt.get<SharedPreferences>().getInt('auctionId'))),
      child: SafeArea(
        child: Scaffold(
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
                  AppStrings.makerauction.tr(),
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
                  if (state is GetMakerByAuctionSuccessState) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: state.model.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: screenHeight * 0.17,
                                  width: screenWidth * 0.9,
                                  decoration: BoxDecoration(
                                      color: AppColor.lightbrownText
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    // leading: ClipRRect(
                                    //   borderRadius: BorderRadius.circular(30),
                                    //   child: Image.network(
                                    //     'http://199.192.19.220:5400${state.model[index].maker_details.image}',
                                    //     width: 70,
                                    //     height: 100,
                                    //     fit: BoxFit.fill,
                                    //     loadingBuilder:
                                    //         (context, error, stackTrace) {
                                    //       if (stackTrace == null) {
                                    //         return Image.network(
                                    //             width: 70,
                                    //             height: 100,
                                    //             fit: BoxFit.fill,
                                    //             'http://199.192.19.220:5400${state.model[index].maker_details.image}');
                                    //       } else {
                                    //         return Shimmer.fromColors(
                                    //           baseColor: Colors.grey.shade300,
                                    //           highlightColor:
                                    //               Colors.grey.shade100,
                                    //           child: ShimmerBodyForImage(
                                    //             width: 70.w,
                                    //             height: 100.h,
                                    //           ),
                                    //         );
                                    //       }
                                    //     },
                                    //     errorBuilder:
                                    //         (context, error, stackTrace) {
                                    //       return Shimmer.fromColors(
                                    //         baseColor: Colors.grey.shade300,
                                    //         highlightColor:
                                    //             Colors.grey.shade100,
                                    //         child: const ShimmerBodyForImage(
                                    //           width: 70,
                                    //           height: 100,
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    title: Text(
                                      state.model[index].maker_details.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontSize: 19),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox_Height(height: 7.h),
                                        RowForIconAndText(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColor.blodbrownText,
                                                  fontSize: 15),
                                          icon: Icons.phone,
                                          text: state.model[index].maker_details
                                              .phone_number
                                              .toString(),
                                        ),
                                        SizedBox_Height(height: 7.h),
                                        RowForIconAndText(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColor.blodbrownText,
                                                  fontSize: 15),
                                          icon: Icons.email,
                                          text: state
                                              .model[index].maker_details.email
                                              .toString(),
                                        ),
                                        SizedBox_Height(height: 7.h),
                                        RowForIconAndText(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColor.blodbrownText,
                                                  fontSize: 15),
                                          icon: Icons.telegram,
                                          text: state.model[index].maker_details
                                              .telegram_id
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
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
        ),
      ),
    );
  }
}
