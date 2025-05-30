import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/domin/model/order_model/add_order_model.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_bloc.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_event.dart';
import 'package:hand_made_app/feature/order/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:hand_made_app/feature/order/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_color.dart';
import '../../home/screen/location_details_screen.dart';
import '../../home/screen/location_screen.dart';
import '../../home/widget/row_of_order.dart';
import '../../share/shimmer_body.dart';
import '../../share/sized_box.dart';
import '../bloc/add_to_cart_bloc/add_to_cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox_Height(height: 7.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.smiling,
                  width: screenWidth * 0.15,
                ),
                SizedBox_width(width: 7.w),
                Column(
                  children: [
                    SizedBox_Height(height: screenHeight * 0.02.h),
                    Text(
                      AppStrings.cart.tr(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                color: AppColor.lightbrownText,
              ),
            ),
            BlocBuilder<AddToCartBloc, AddToCartState>(
              builder: (context, state) {
                var bloc = BlocProvider.of<AddToCartBloc>(
                    context); // Calculate the total price
                double totalPrice = bloc.cartItems.fold(0, (sum, item) {
                  final price = item.discounts.isEmpty
                      ? double.tryParse(item.handcraft_price) ?? 0
                      : double.tryParse(item.discounted_price.toString()) ?? 0;
                  return sum + (price * item.quantity);
                });
                print(totalPrice);
                if (bloc.cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox_Height(height: screenHeight * 0.4),
                        Image.asset(
                          AppAssets.sad,
                          width: 40.w,
                        ),
                        Text(
                          AppStrings.noProductfoundInCart.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.72,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: bloc.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = bloc.cartItems[index];
                              final availableStock = item.handcraft_count;
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      // height: screenHeight * 0.15,
                                      decoration: BoxDecoration(
                                          color: AppColor.lightbrownText
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      'http://199.192.19.220:5400/${item.handcraft_image}',
                                                      width: screenWidth * 0.15,
                                                      height:
                                                          screenHeight * 0.1,
                                                      fit: BoxFit.fitWidth,
                                                      loadingBuilder: (context,
                                                          error, stackTrace) {
                                                        if (stackTrace ==
                                                            null) {
                                                          return Image.network(
                                                              width:
                                                                  screenWidth *
                                                                      0.15,
                                                              height:
                                                                  screenHeight *
                                                                      0.1,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              'http://199.192.19.220:5400/${item.handcraft_image}');
                                                        } else {
                                                          return Shimmer
                                                              .fromColors(
                                                            baseColor: Colors
                                                                .grey.shade300,
                                                            highlightColor:
                                                                Colors.grey
                                                                    .shade100,
                                                            child:
                                                                ShimmerBodyForImage(
                                                              width:
                                                                  screenWidth *
                                                                      0.15,
                                                              height:
                                                                  screenHeight *
                                                                      0.1,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Shimmer
                                                            .fromColors(
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          child:
                                                              ShimmerBodyForImage(
                                                            width: screenWidth *
                                                                0.15,
                                                            height:
                                                                screenHeight *
                                                                    0.1,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox_width(width: 10.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          RowOfOrder(
                                                            title1: item
                                                                .handcraft_name,
                                                            title2: '',
                                                          ),
                                                          SizedBox_width(
                                                              width:
                                                                  screenWidth *
                                                                      0.4),
                                                          Container(
                                                            width: 35.w,
                                                            height: 30.h,
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .background,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  context
                                                                      .read<
                                                                          AddToCartBloc>()
                                                                      .add(DeleteFromcartEvent(
                                                                          id: item
                                                                              .id));
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: AppColor
                                                                      .primary,
                                                                  size: 25,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${AppStrings.totalPrice.tr()} :',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall!
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .brown,
                                                                    fontSize:
                                                                        15.sp),
                                                          ),
                                                          SizedBox_width(
                                                              width: 5.w),
                                                          Text(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            item.discounts
                                                                    .isEmpty
                                                                ? '${item.handcraft_price} ل.س'
                                                                : '${item.handcraft_price.toString()} ل.س',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium!
                                                                .copyWith(
                                                                  fontSize: 13,
                                                                  color: AppColor
                                                                      .blodbrownText,
                                                                  decorationColor:
                                                                      AppColor
                                                                          .primary,
                                                                  decorationThickness:
                                                                      2,
                                                                  decoration: item
                                                                          .discounts
                                                                          .isEmpty
                                                                      ? TextDecoration
                                                                          .none
                                                                      : TextDecoration
                                                                          .lineThrough,
                                                                ),
                                                          ),
                                                          SizedBox_width(
                                                              width: 5.w),
                                                          if (item.discounts
                                                              .isNotEmpty)
                                                            Text(
                                                              '${item.discounted_price.toString()} ل.س',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.remove,
                                                          size: 20,
                                                          color:
                                                              AppColor.primary),
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                AddToCartBloc>()
                                                            .add(
                                                                RemoveFromcartEvent(
                                                                    id: item
                                                                        .id));
                                                      },
                                                    ),
                                                    Text(
                                                      item.quantity.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.add,
                                                          size: 20,
                                                          color:
                                                              AppColor.primary),
                                                      onPressed: () {
                                                        if (item.quantity >
                                                            availableStock) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                '${AppStrings.outOfStock.tr()}, ${AppStrings.availableQuantity.tr()} : $availableStock',
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                          return; // Exit the function if stock is insufficient
                                                        }
                                                        context
                                                            .read<
                                                                AddToCartBloc>()
                                                            .add(
                                                                AddToCartSuccessEvent(
                                                                    handcraft:
                                                                        item));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (item.quantity >=
                                                  availableStock)
                                                Text(
                                                  '${AppStrings.outOfStock.tr()}, ${AppStrings.availableQuantity.tr()} : $availableStock',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                          fontSize: 14.sp,
                                                          color:
                                                              AppColor.primary),
                                                )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.wallet,
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.03,
                                  fit: BoxFit.fitWidth,
                                ),
                                SizedBox_width(width: 3.w),
                                Text(
                                  '${AppStrings.fullOrderPrice.tr()}:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          decorationColor: AppColor.primary,
                                          decoration: TextDecoration.underline),
                                )
                              ],
                            ),
                            Text(
                              ' $totalPrice ل.س',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                          width: screenWidth * 0.5,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LocationScreen(fromCart: true),
                              ),
                            );
                            // context
                            //     .read<AddOrderBloc>()
                            //     .add(AddOrderSuccessEvent(
                            //         addOrderModel: AddOrderModel(
                            //             customer_phone: '0931824106',
                            //             handcraft: bloc.cartItems
                            //                 .map((item) => HandCraft(
                            //                       handcraft_id: item.id,
                            //                       quantity: item.quantity,
                            //                     ))
                            //                 .toList())));
                          },
                          text: AppStrings.confirmOrder.tr()),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
