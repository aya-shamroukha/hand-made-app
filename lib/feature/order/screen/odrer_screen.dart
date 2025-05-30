import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/order/bloc/get_order_bloc/get_order_bloc.dart';
import 'package:hand_made_app/feature/order/bloc/get_order_bloc/get_order_event.dart';
import 'package:hand_made_app/feature/order/bloc/get_order_bloc/get_order_state.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/app_color.dart';
import '../../share/shimmer_body.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (context) => GetOrderBloc()..add(GetOrderSuccessEvent()),
        child: SafeArea(
            child: Scaffold(
                body: Column(
          children: [
            SizedBox_Height(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.myodrer,
                  width: screenWidth * 0.12,
                ),
                SizedBox_width(width: 7.w),
                Text(
                  AppStrings.myorder.tr(),
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
            BlocBuilder<GetOrderBloc, GetOrderState>(
              builder: (context, state) {
                if (state is GetOrderSuccessState) {
                  return SizedBox(
                    height: screenHeight * 0.79,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            // separatorBuilder: (context, index) {
                            //   return Padding(
                            //     padding:
                            //         const EdgeInsets.symmetric(horizontal: 15.0),
                            //     child: Divider(
                            //       color: AppColor.lightbrownText,
                            //     ),
                            //   );
                            // },
                            itemCount: state.order.length,
                            itemBuilder: (context, index) {
                              final order = state.order[index];
                              return InkWell(
                                //                       // onTap: () {
                                //                       //   Navigator.of(context).pushNamed('clothes_details',
                                //                       //       arguments: state.order[index].id);
                                //                       // },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.lightbrownText
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://199.192.19.220:5400/${order.orderhandcrafts[0].handcraft.handcraft_image}',
                                            width: screenWidth * 0.15,
                                            height: screenHeight * 0.2,
                                            fit: BoxFit.fitWidth,
                                            loadingBuilder:
                                                (context, error, stackTrace) {
                                              if (stackTrace == null) {
                                                return Image.network(
                                                    width: screenWidth * 0.15,
                                                    height: screenHeight * 0.2,
                                                    fit: BoxFit.fitWidth,
                                                    'http://199.192.19.220:5400/${order.orderhandcrafts[0].handcraft.handcraft_image}');
                                              } else {
                                                return Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: ShimmerBodyForImage(
                                                    width: screenWidth * 0.15,
                                                    height: screenHeight * 0.2,
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
                                                  width: screenWidth * 0.15,
                                                  height: screenHeight * 0.2,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          order.orderhandcrafts[0].handcraft
                                              .handcraft_name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                color: AppColor.brown,
                                              ),
                                        ),
                                        subtitle: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${AppStrings.isdeliverd.tr()} :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: AppColor.brown,
                                                        fontSize: 13.sp),
                                              ),
                                              Container(
                                                width: 25.w,
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                    color: AppColor
                                                        .lightbrownText
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Icon(
                                                  state.order[index].delivery
                                                      ? Icons.check
                                                      : Icons.close,
                                                  color: state
                                                          .order[index].delivery
                                                      ? AppColor.primary
                                                      : AppColor.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: SizedBox(
                                          height: 70,
                                          width: 120,
                                          child: Column(
                                            children: [
                                              Text(
                                                '${state.order[index].full_price.toString()} ل.س',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: AppColor
                                                            .blodbrownText,
                                                        fontSize: 11.sp),
                                              ),
                                              SizedBox_Height(height: 5.h),
                                              Text(
                                                order.date_of_order.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        color: AppColor
                                                            .blodbrownText,
                                                        fontSize: 11.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            }),
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
            ),
          ],
        ))));
  }
}
