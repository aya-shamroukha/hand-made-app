// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_event.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_state.dart';

import 'package:hand_made_app/feature/home/widget/columnfor_details_location.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';

import '../../../core/config/local_storage/sqflite.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../share/positioned_for_icon.dart';

class LocationDetailsScreen extends StatelessWidget {
  final bool fromCart;
  LocationDetailsScreen({super.key, required this.fromCart});
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
                builder: (context, state) {
                  // final routeArgs = ModalRoute.of(context)?.settings.arguments
                  //     as Map<String, dynamic>?;
                  // final fromCart = routeArgs?['fromCart'] ?? false;
                  var bloc = BlocProvider.of<LocationDetailsBloc>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox_width(width: 17.w),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/map (1).png',
                                width: screenWidth * 0.1,
                                // height: screenHeight * 0.2,
                                //   fit: BoxFit.fitWidth,
                              ),
                              SizedBox_width(width: 7.w),
                              Text(
                                AppStrings.LocationDetails.tr(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              PositionedForIcon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          color: AppColor.lightbrownText,
                        ),
                      ),
                      SizedBox_Height(height: 10.h),
                      ColumnForDetailsLocation(
                        hint: AppStrings.theArea.tr(),
                        text: AppStrings.theArea.tr(),
                        controller: bloc.area,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return AppStrings.notexthere.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox_Height(height: 20.h),
                      ColumnForDetailsLocation(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return AppStrings.notexthere.tr();
                          }
                          return null;
                        },
                        hint: AppStrings.theStreet.tr(),
                        text: AppStrings.theStreet.tr(),
                        controller: bloc.street,
                      ),
                      SizedBox_Height(height: 20.h),
                      ColumnForDetailsLocation(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return AppStrings.notexthere.tr();
                          }
                          return null;
                        },
                        hint: '''
                     مثال : المبنى الاول , الطابق الثاني
                     ثم اضغط على الجرس
                    
                     لا تقم بإضافة تغيرات أو طلبات على الطلب هنا
                     ''',
                        text: AppStrings.LocationDetails.tr(),
                        controller: bloc.details,
                      ),
                      SizedBox_Height(height: 10.h),
                      ColumnForDetailsLocation(
                        validator: (val) {
                          if (val!.length < 10 || val == null) {
                            return AppStrings.enterTheVaildNumber.tr();
                          }

                          return null;
                        },
                        hint: AppStrings.phone.tr(),
                        text: AppStrings.phone.tr(),
                        controller: bloc.phone,
                      ),
                      SizedBox_Height(height: screenHeight * 0.07),
                      Center(
                        child: CustomButton(
                            text: AppStrings.LocationConfirm.tr(),
                            width: screenWidth * 0.6,
                            onPressed: () async {
                              if (globalKey.currentState!.validate()) {
                                context
                                    .read<LocationDetailsBloc>()
                                    .add(InsertDetailsEvent(
                                        locationModel: LocationModel(
                                      area: bloc.area.text,
                                      street: bloc.street.text,
                                      phone: bloc.phone.text,
                                      details: bloc.details.text,
                                    )));
                                print(bloc.list);
                                await Future.delayed(Duration(seconds: 1));
                                if (this.fromCart) {
                                  Navigator.of(context).pushNamed(
                                      'finalorder'); // From cart → final order
                                } else {
                                  Navigator.of(context)
                                      .pushReplacementNamed('address');
                                  bloc.street.clear();
                                  bloc.area.clear();
                                  bloc.phone.clear();
                                  bloc.details.clear();
                                }
                              }
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
