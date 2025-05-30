import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_state.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_event.dart';
import 'package:hand_made_app/feature/categories/screen/comment_screen.dart';

import 'package:hand_made_app/feature/order/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';
import 'package:hand_made_app/feature/order/bloc/add_to_cart_bloc/add_to_cart_event.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/shimmer_body.dart';
import 'package:hand_made_app/feature/share/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../order/bloc/add_to_cart_bloc/add_to_cart_state.dart';
import '../../share/custom_button.dart';
import '../../share/positioned_for_icon.dart';
import '../../share/sized_box.dart';

import '../bloc/get_categories/get_hand_craf_detail_bloc/get_hand_craft_detail_bloc.dart';
import '../bloc/get_categories/get_hand_craf_detail_bloc/get_hand_craft_detail_event.dart';
import '../bloc/get_categories/get_hand_craf_detail_bloc/get_hand_craft_detail_state.dart';
import '../bloc/get_rating_bloc/get_rating_bloc.dart';
import '../bloc/get_rating_bloc/get_rating_state.dart';
import '../widget/container_for_rating.dart';
import '../widget/row_for_aitext.dart';
import '../widget/row_for_text.dart';

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CommentScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 1000),
  );
}

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetHandCraftDetailBloc()
            ..add(GetHandCraftDetailSuccessEvent(
                id: getIt.get<SharedPreferences>().getInt(
                      'id details',
                    ))),
        ),
        BlocProvider(
          create: (context) => GetRatingBloc()
            ..add(GetRatingSuccessEvent(
                id: getIt.get<SharedPreferences>().getInt(
                      'id details',
                    ))),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            floatingActionButton: Tooltip(
              message: AppStrings.cart.tr(),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('cartscreen');
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.primary),
                      child: Icon(
                        Icons.shopping_cart,
                        color: AppColor.background,
                      ),
                    ),
                    Positioned(
                        top: -5,
                        right: 0,
                        child: BlocBuilder<AddToCartBloc, AddToCartState>(
                          builder: (context, state) {
                            final cart =
                                BlocProvider.of<AddToCartBloc>(context);
                            if (cart.cartItems.isEmpty) {
                              return const SizedBox(); // Return an empty widget instead of null
                            }

                            return Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: AppColor.background,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                ' ${BlocProvider.of<AddToCartBloc>(context).cartItems.fold(0, (sum, item) => sum + item.quantity)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: AppColor.primary,
                                        fontSize: 14.sp),
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
            ),
            body: BlocBuilder<GetHandCraftDetailBloc, GetHandCraftDetailState>(
              builder: (context, stat) {
                if (stat is GetHandCraftDetailSuccessState) {
                  final availableStock = stat.handcraft.handcraft_count;
                  getIt.get<SharedPreferences>().setString('craftimage',
                      'http://199.192.19.220:5400//${stat.handcraft.handcraft_image}');
                  return Stack(
                    children: [
                      PositionedForIcon(
                        left: 0,
                        top: screenHeight * 0.04,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),

                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: screenHeight * 0.5,
                          width: screenWidth * 1,
                          decoration: BoxDecoration(
                              color: AppColor.lightbrownText.withOpacity(0.6),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(70),
                                topRight: Radius.circular(70),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox_Height(height: screenHeight * 0.04),

                                Text(
                                  '. ${stat.handcraft.handcraft_name}',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),

                                Row(
                                  children: [
                                    Text(
                                      '. ${AppStrings.price.tr()}: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      stat.handcraft.discounts.isEmpty
                                          ? '${stat.handcraft.handcraft_price} ل.س'
                                          : '${stat.handcraft.handcraft_price.toString()} ل.س',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            color:
                                                AppColor.brown.withOpacity(0.7),
                                            fontSize: 17,
                                            decorationColor: AppColor.primary,
                                            decorationThickness: 2,
                                            decoration: stat
                                                    .handcraft.discounts.isEmpty
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough,
                                          ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox_width(width: 7.w),
                                    if (stat.handcraft.discounts.isNotEmpty)
                                      Text(
                                        '${stat.handcraft.discounted_price.toString()} ل.س',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontSize: 17,
                                              color: Colors.red,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                  ],
                                ),

                                RowForText(
                                  text1: '. الكمية: ',
                                  text2: stat.handcraft.handcraft_count == 0
                                      ? ' المنتج غير متوفر'
                                      : ' ${stat.handcraft.handcraft_count.toString()}',
                                ),
                                SizedBox_Height(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: AppColor.brown.withOpacity(0.5),
                                  ),
                                ),
                                //!forComment
                                SizedBox_Height(height: 5.h),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(_createRoute());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        color: AppColor.primary,
                                      ),
                                      SizedBox_width(width: 7.w),
                                      Text(
                                        AppStrings.comment.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontSize: 17,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox_Height(height: 5.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: AppColor.brown.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //!forRating
                                BlocBuilder<GetRatingBloc, GetRatingState>(
                                    builder: (context, state) {
                                  if (state is GetRatingSuccessState) {
                                    return RowForRating(
                                      rating: state.rating.toDouble(),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                                SizedBox_Height(height: 15.h),
                                //!ForAi
                                const RowForAiText(),
                                SizedBox_Height(height: 20.h),
                                // CustomButton(
                                //     height: 30,
                                //     onPressed: () {
                                //       Navigator.of(context)
                                //           .pushNamed('cartscreen');
                                //     },
                                //     text: 'cart'),
                                //!foraddTocart
                                BlocBuilder<AddToCartBloc, AddToCartState>(
                                  builder: (context, state) {
                                    return Center(
                                      child: CustomButton(
                                          onPressed: () {
                                            if (stat.handcraft.quantity >=
                                                availableStock) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '${AppStrings.outOfStock.tr()}, ${AppStrings.availableQuantity.tr()} : $availableStock',
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );

                                              return; // Exit the function if stock is insufficient
                                            }
                                            context.read<AddToCartBloc>().add(
                                                AddToCartSuccessEvent(
                                                    handcraft: stat.handcraft));

                                            showTost(
                                                message: 'تمت الاضافة',
                                                state: ToastState.success);
                                          },
                                          textcolor: AppColor.background,
                                          height: screenHeight * 0.05,
                                          width: screenWidth * 0.4,
                                          text: AppStrings.addtocart.tr()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //!forHandcraftImage
                      Positioned(
                        bottom: screenHeight * 0.5,
                        left: screenWidth * 0.18,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                  stat.handcraft.handcraft_count == 0
                                      ? ' المنتج غير متوفر'
                                      : '',
                                  style: stat.handcraft.handcraft_count == 0
                                      ? Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: AppColor.red,
                                              fontWeight: FontWeight.bold)
                                      : Theme.of(context)
                                          .textTheme
                                          .displaySmall!),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://199.192.19.220:5400/${stat.handcraft.handcraft_image}',
                                  width: screenWidth * 0.7,
                                  height: screenHeight * 0.2,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ShimmerBodyForImage(
                                      width: 60.w,
                                      height: 50.h,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Loading(),
                  );
                }
              },
            ));
      }),
    );
  }
}
