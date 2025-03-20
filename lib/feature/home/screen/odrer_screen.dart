import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/home/bloc/bloc/get_order_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/bloc/get_order_event.dart';
import 'package:hand_made_app/feature/home/bloc/bloc/get_order_state.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/app_color.dart';
import '../../share/shimmer_body.dart';

import '../widget/row_of_order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColor.lightbrownText,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/v.png',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox_width(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مزهرية لوضع الزهور',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 250.00',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 19/03/1025',
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
            SizedBox_Height(height: 15.h),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColor.lightbrownText,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/g.jpg',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox_width(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مخدة نوم ',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 150.00',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 18/02/1025',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Row(
                      children: [
                        Text(
                          ' تم التوصيل',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColor.brown.withOpacity(0.7),
                                  fontSize: 17),
                        ),
                        SizedBox_width(width: 7.w),
                        Container(
                          width: 25.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightbrownText.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.check, color: Colors.green),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox_Height(height: 15.h),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColor.lightbrownText,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/n.jpg',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.01,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox_width(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اطار حائط',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 50.00',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 19/03/1025',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Row(
                      children: [
                        Text(
                          ' في الانتظار ',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColor.brown.withOpacity(0.7),
                                  fontSize: 17),
                        ),
                        SizedBox_width(width: 7.w),
                        Container(
                          width: 25.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightbrownText.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.close, color: Colors.red),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox_Height(height: 15.h),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColor.lightbrownText,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/t.jpg',
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.15,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox_width(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مراة يدوية الصنع',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 250.00',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Text(
                      ' 19/03/1025',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColor.brown.withOpacity(0.7),
                              fontSize: 17),
                    ),
                    SizedBox_Height(height: 5.h),
                    Row(
                      children: [
                        Text(
                          ' تم التوصيل',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColor.brown.withOpacity(0.7),
                                  fontSize: 17),
                        ),
                        SizedBox_width(width: 7.w),
                        Container(
                          width: 25.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: AppColor.lightbrownText.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.check, color: Colors.green),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ));
    // return BlocProvider(
    //   create: (context) => GetOrderBloc()..add(GetOrderSuccessEvent()),
    //   child: SafeArea(child: Scaffold(
    //     body: BlocBuilder<GetOrderBloc, GetOrderState>(
    //       builder: (context, state) {
    //         if (state is GetOrderSuccessState) {
    //           return Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: ListView.builder(
    //                   itemCount: state.order.length,
    //                   itemBuilder: (context, index) {
    //                     return InkWell(
    //                       // onTap: () {
    //                       //   Navigator.of(context).pushNamed('clothes_details',
    //                       //       arguments: state.order[index].id);
    //                       // },
    //                       child: Row(
    //                         children: [
    //                           // Padding(
    //                           //   padding: const EdgeInsets.all(10),
    //                           //   child: ClipRRect(
    //                           //     borderRadius: BorderRadius.circular(20),
    //                           //     child: Image.network(
    //                           //       'http://199.192.19.220:5400/${state.order[index].orderhandcrafts[index].handcraft.handcraftImage}',
    //                           //       width: 120.w,
    //                           //       fit: BoxFit.cover,
    //                           //       height: 120.h,
    //                           //       loadingBuilder:
    //                           //           (context, error, stackTrace) {
    //                           //         if (stackTrace == null) {
    //                           //           return Image.network(
    //                           //               width: screenWidth * 0.6,
    //                           //               height: screenHeight * 0.02,
    //                           //               fit: BoxFit.fill,
    //                           //               'http://199.192.19.220:5400/${state.order[index].orderhandcrafts[index].handcraft.handcraftImage}');
    //                           //         } else {
    //                           //           return Shimmer.fromColors(
    //                           //             baseColor: Colors.grey.shade300,
    //                           //             highlightColor: Colors.grey.shade100,
    //                           //             child: ShimmerBodyForImage(
    //                           //               height: screenHeight * 0.1.h,
    //                           //               width: screenWidth * 0.2.w,
    //                           //             ),
    //                           //           );
    //                           //         }
    //                           //       },
    //                           //       errorBuilder: (context, error, stackTrace) {
    //                           //         return Shimmer.fromColors(
    //                           //           baseColor: Colors.grey.shade300,
    //                           //           highlightColor: Colors.grey.shade100,
    //                           //           child: ShimmerBodyForImage(
    //                           //             height: screenHeight * 0.1.h,
    //                           //             width: screenWidth * 0.2.w,
    //                           //           ),
    //                           //         );
    //                           //       },
    //                           //     ),
    //                           //   ),
    //                           // ),
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               // RowOfOrder(
    //                               //   title1: 'الاسم :',
    //                               //   title2: state
    //                               //       .order[index]
    //                               //       .orderhandcrafts[index]
    //                               //       .handcraft
    //                               //       .handcraft_name,
    //                               // ),
    //                               SizedBox_Height(height: 10.h),
    //                               RowOfOrder(
    //                                 title1: 'Date of order :',
    //                                 title2: state.order[index].date_of_order
    //                                     .toString(),
    //                               ),
    //                               RowOfOrder(
    //                                   title1: 'Cost :',
    //                                   title2: state.order[index].customer_phone
    //                                       .toString()),
    //                               Row(
    //                                 children: [
    //                                   Text(
    //                                     'Is deliverd :  ',
    //                                     style: Theme.of(context)
    //                                         .textTheme
    //                                         .displaySmall!
    //                                         .copyWith(color: AppColor.brown),
    //                                   ),
    //                                   Container(
    //                                     width: 25.w,
    //                                     height: 20.h,
    //                                     decoration: BoxDecoration(
    //                                         color: AppColor.lightbrownText
    //                                             .withOpacity(0.5),
    //                                         borderRadius:
    //                                             BorderRadius.circular(20)),
    //                                     child: Icon(
    //                                       state.order[index].delivery
    //                                           ? Icons.check
    //                                           : Icons.close,
    //                                       color: state.order[index].delivery
    //                                           ? Colors.green
    //                                           : AppColor.red,
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                               RowOfOrder(
    //                                 title1: 'السعر الاجمالي :',
    //                                 title2: state.order[index].full_price
    //                                     .toString(),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                   }),
    //             ),
    //           );
    //         } else {
    //           return SizedBox(
    //             height: double.maxFinite,
    //             width: 400,
    //             child: Expanded(
    //               child: ListView.builder(
    //                   scrollDirection: Axis.vertical,
    //                   itemCount: 11,
    //                   itemBuilder: ((context, index) {
    //                     return Shimmer.fromColors(
    //                       baseColor: Colors.grey.shade300,
    //                       highlightColor: Colors.grey.shade100,
    //                       child: ShimmerBodyForImage(
    //                         height: 155.h,
    //                         width: 400.w,
    //                       ),
    //                     );
    //                   })),
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   )),
    // );
  }
}
