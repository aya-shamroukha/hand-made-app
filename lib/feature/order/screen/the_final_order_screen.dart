import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_bloc.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_state.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/toast.dart';

import '../../../core/domin/model/order_model/add_order_model.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../home/bloc/location_details/location_details_bloc.dart';
import '../../home/screen/location_details_screen.dart';
import '../../share/sized_box.dart';
import '../bloc/add_order_bloc/add_order_event.dart';
import '../bloc/add_to_cart_bloc/add_to_cart_bloc.dart';

class TheFinalOrderScreen extends StatelessWidget {
  const TheFinalOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = context.read<LocationDetailsBloc>();
    final cartBloc = context.read<AddToCartBloc>();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        AppStrings.theFinalOrder.tr(),
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
              SizedBox_Height(height: 7.h),
              BlocConsumer<AddOrderBloc, AddOrderState>(
                listener: (context, state) {
                  if (state is AddOrderSuccessState) {
                    showTost(
                        message: AppStrings.theOrderGetSuccessfully.tr(),
                        state: ToastState.success);
                    Navigator.of(context).pushReplacementNamed('bottom');
                  } else if (state is AddOrderFieldState) {
                    showTost(
                        message: AppStrings.somethingwentwrong.tr(),
                        state: ToastState.error);
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.myAddresses.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox_Height(height: 8.h),
                          Container(
                            height: screenHeight * 0.13,
                            width: screenWidth * 1,
                            decoration: BoxDecoration(
                                color: AppColor.lightbrownText.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ● ${locationBloc.area.text} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: AppColor.blodbrownText),
                                      ),
                                      Text(
                                        ' ● ${locationBloc.street.text} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: AppColor.blodbrownText),
                                      ),
                                      Text(
                                        ' ● ${locationBloc.details.text} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: AppColor.blodbrownText),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LocationDetailsScreen(
                                                  fromCart: true),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppStrings.change.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color: AppColor.primary,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColor.primary),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox_Height(height: 10.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              color: AppColor.lightbrownText,
                            ),
                          ),
                          SizedBox_Height(height: 10.h),
                          Text(
                            AppStrings.price.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 1,
                            decoration: BoxDecoration(
                                color: AppColor.lightbrownText.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                              decoration:
                                                  TextDecoration.underline),
                                    )
                                  ],
                                ),
                                Text(
                                  ' ${_calculateTotalPrice(cartBloc.cartItems)} ل.س',
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
                          SizedBox_Height(
                            height: screenHeight * 0.44,
                          ),
                          state is AddOrderLoadingState
                              ? const Loading()
                              : Center(
                                  child: CustomButton(
                                      width: screenWidth * 0.5,
                                      onPressed: () {
                                        context.read<AddOrderBloc>().add(
                                            AddOrderSuccessEvent(
                                                addOrderModel: AddOrderModel(
                                                    customer_phone:
                                                        '0931824106',
                                                    handcraft: cartBloc
                                                        .cartItems
                                                        .map(
                                                            (item) => HandCraft(
                                                                  handcraft_id:
                                                                      item.id,
                                                                  quantity: item
                                                                      .quantity,
                                                                ))
                                                        .toList())));
                                      },
                                      text: AppStrings.confirmOrder.tr()),
                                ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCartItem(dynamic item) {
  return ListTile(
    leading: Image.network(
      'http://199.192.19.220:5400/${item.handcraft_image}',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    ),
    title: Text(item.handcraft_name),
    subtitle: Text(
      item.discounts.isEmpty
          ? '${item.handcraft_price} ل.س'
          : '${item.discounted_price} ل.س',
    ),
    trailing: Text('Quantity: ${item.quantity}'),
  );
}

String _calculateTotalPrice(List<dynamic> cartItems) {
  double totalPrice = cartItems.fold(0, (sum, item) {
    final price = item.discounts.isEmpty
        ? double.tryParse(item.handcraft_price.toString()) ?? 0
        : double.tryParse(item.discounted_price.toString()) ?? 0;
    return sum + (price * item.quantity);
  });
  return totalPrice.toStringAsFixed(2);
}
