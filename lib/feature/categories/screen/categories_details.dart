// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_event.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_state.dart';

import 'package:hand_made_app/feature/categories/bloc/bloc/get_hand_craf_detail_bloc/get_hand_craft_detail_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/bloc/get_hand_craf_detail_bloc/get_hand_craft_detail_event.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_event.dart';

import 'package:hand_made_app/feature/share/positioned_for_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/domin/model/categories_model/add_comment_model.dart';
import '../../../core/resources/app_string.dart';
import '../../share/custom_text_field.dart';
import '../../share/shimmer_body.dart';
import '../../share/sized_box.dart';
import '../bloc/bloc/get_hand_craf_detail_bloc/get_hand_craft_detail_state.dart';
import '../bloc/get_rating_bloc/get_rating_state.dart';
import '../widget/row_for_text.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController comment = TextEditingController();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddNewCommentBloc(),
          ),
          BlocProvider(
            create: (context) => GetRatingBloc()
              ..add(GetRatingSuccessEvent(
                  id: getIt.get<SharedPreferences>().getInt(
                        'id details',
                      ))),
          ),
          BlocProvider(
            create: (context) => GetHandCraftDetailBloc()
              ..add(GetHandCraftDetailSuccessEvent(
                  id: getIt.get<SharedPreferences>().getInt(
                        'id details',
                      ))),
          ),
        ],
        child: Builder(builder: (context) {
          return Scaffold(body:
              BlocBuilder<GetHandCraftDetailBloc, GetHandCraftDetailState>(
            builder: (context, state) {
              if (state is GetHandCraftDetailSuccessState) {
                getIt.get<SharedPreferences>().setString('craftimage',
                    'http://199.192.19.220:5400${state.handcraft.handcraft_image}');
                return Stack(
                  children: [
                    PositionedForIcon(
                      left: 0,
                      top: screenHeight * 0.04,
                      iconColor: AppColor.blodbrownText,
                      color: AppColor.brownText,
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
                            color: AppColor.brownText,
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
                                '. ${state.handcraft.handcraft_name}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              RowForText(
                                  text1: '. ${AppStrings.price.tr()}: ',
                                  text2: state.handcraft.handcraft_price),
                              RowForText(
                                text1: '. الكمية: ',
                                text2:
                                    ' ${state.handcraft.handcraft_count.toString()}',
                              ),
                              SizedBox_Height(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: AppColor.brown.withOpacity(0.5),
                                ),
                              ),
                              BlocBuilder<AddNewCommentBloc,
                                  AddNewCommentState>(
                                builder: (context, state) {
                                  return TextButton(
                                      onPressed: () {
                                        context.read<AddNewCommentBloc>().add(
                                            GetCommentSuccessEvent(
                                                id: getIt
                                                    .get<SharedPreferences>()
                                                    .getInt(
                                                      'id details',
                                                    )));
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                    height: screenHeight * 0.5,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColor.background,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: state
                                                            is GetCommentSuccessState
                                                        ? Column(
                                                            children: [
                                                              Expanded(
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: state
                                                                              .getcomment
                                                                              .length,
                                                                          scrollDirection: Axis
                                                                              .vertical,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return ListTile(
                                                                                trailing: Text(state.getcomment[index].date, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 10, color: AppColor.blodbrownText)),
                                                                                title: Text(
                                                                                  state.getcomment[index].customer_name,
                                                                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 17),
                                                                                ),
                                                                                leading: Container(
                                                                                  width: 30.w,
                                                                                  height: 25.h,
                                                                                  decoration: BoxDecoration(color: AppColor.lightbrownText.withOpacity(0.7), borderRadius: BorderRadius.circular(100)),
                                                                                  child: Icon(
                                                                                    Icons.person,
                                                                                    color: AppColor.primary,
                                                                                  ),
                                                                                ),
                                                                                subtitle: Text(
                                                                                  state.getcomment[index].description,
                                                                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14, color: AppColor.blodbrownText),
                                                                                ));
                                                                          })),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  SizedBox(
                                                                    width: screenWidth *
                                                                        0.55.w,
                                                                    height:
                                                                        screenHeight *
                                                                            0.07.h,
                                                                    child: CustomTextfield(
                                                                        controller:
                                                                            comment,
                                                                        labeltext:
                                                                            'Add Comment'),
                                                                  ),
                                                                  //  stat is AddNewCommentLoadingState
                                                                  //     ? const Loading()
                                                                  InkWell(
                                                                    onTap: () {
                                                                      context.read<AddNewCommentBloc>().add(AddNewCommentSuccessEvent(
                                                                          addComment: AddCommentModel(
                                                                              time: DateTime.now().toString(),
                                                                              date: DateTime(DateTime.monthsPerYear).toString(),
                                                                              description: comment.text.toString(),
                                                                              handcraft: getIt.get<SharedPreferences>().getInt(
                                                                                    'id details',
                                                                                  ))));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          30.w,
                                                                      height:
                                                                          25.h,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColor.lightbrownText.withOpacity(
                                                                              0.7),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_forward,
                                                                          color:
                                                                              AppColor.primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        : Expanded(
                                                            child: SizedBox(
                                                              height: double
                                                                  .maxFinite,
                                                              width: 400,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      itemCount:
                                                                          10,
                                                                      itemBuilder:
                                                                          ((context,
                                                                              index) {
                                                                        return Shimmer
                                                                            .fromColors(
                                                                          baseColor: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          highlightColor: Colors
                                                                              .grey
                                                                              .shade100,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                ShimmerBodyForImage(
                                                                              height: screenHeight * 0.07,
                                                                              width: screenWidth * 0.8,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      })),
                                                            ),
                                                          )),
                                              );
                                            });
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
                                      ));
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: AppColor.brown.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              BlocBuilder<GetRatingBloc, GetRatingState>(
                                  builder: (context, state) {
                                if (state is GetRatingSuccessState) {
                                  return Container(
                                    child: RatingBar.builder(
                                      unratedColor: AppColor.lightbrownText,
                                      initialRating: state.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 30, // Size of the stars
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: AppColor
                                            .primary, // Color of the stars
                                      ),
                                      onRatingUpdate: (newRating) {
                                        // Optional: Handle user interaction if needed
                                      },
                                      ignoreGestures:
                                          true, // Disable user interaction
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                              SizedBox_Height(height: 15.h),
                              Row(
                                children: [
                                  Text(
                                    'يمكنك المحاكاة من هنا :',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox_width(width: 10.w),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('ai');
                                        //  showDialogForImage(context);
                                      },
                                      label: Text('محاكاة',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color:
                                                      AppColor.lightbrownText)))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.5,
                      left: screenWidth * 0.18,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'http://199.192.19.220:5400/${state.handcraft.handcraft_image}',
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.2,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return ShimmerBodyForImage(
                                width: 60.w,
                                height: 50.h,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.primary,
                ));
              }
            },
          ));
        }));
  }
}
