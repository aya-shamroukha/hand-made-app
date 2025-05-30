import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/sqflite.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_event.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_state.dart';
import 'package:hand_made_app/feature/home/widget/custom_divider.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../../share/custom_button.dart';
import '../../share/sized_box.dart';

// ignore: must_be_immutable
class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  LocationModel? locationModel;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LocationDetailsBloc()..add(GetDetailsEvent()),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
              builder: (context, state) {
                var bloc = BlocProvider.of<LocationDetailsBloc>(context);

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/destination.png',
                          width: screenWidth * 0.1,
                          // height: screenHeight * 0.2,
                          //   fit: BoxFit.fitWidth,
                        ),
                        SizedBox_width(width: 7.w),
                        Text(
                          AppStrings.myAddresses.tr(),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    SizedBox_Height(height: 7.h),
                    const CustomDivider(),
                    SizedBox_Height(height: screenHeight * 0.02),
                    Expanded(
                      child: bloc.list.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.sad,
                                    width: 40.w,
                                  ),
                                  Text(
                                    AppStrings.noaddressesfound.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: bloc.list.length,
                              itemBuilder: (context, index) {
                                final location = bloc.list[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: screenWidth * 0.97,
                                      height: screenHeight * 0.13,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightbrownText,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColor.brownText),
                                      ),
                                      child: ListTile(
                                        trailing: IconButton(
                                            onPressed: () async {
                                              if (location.id != null) {
                                                // Ensure the id is not null
                                                await getIt<Sqflite>()
                                                    .deleteFromDB(location.id!);
                                                context
                                                    .read<LocationDetailsBloc>()
                                                    .add(GetDetailsEvent());
                                              } else {
                                                print('Location ID is null');
                                              }

                                              print(bloc.list.length);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppColor.primary,
                                              size: 25,
                                            )),
                                        leading: Icon(
                                          Icons.location_on,
                                          color: AppColor.primary,
                                          size: 40,
                                        ),
                                        title: Text(
                                          location.area ?? 'No area',
                                          // LocationModel[index].,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              location.street ?? 'NO Street',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: AppColor
                                                          .blodbrownText,
                                                      fontSize: 17),
                                            ),
                                            Text(
                                              location.details ?? 'NO Street',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: AppColor
                                                          .blodbrownText,
                                                      fontSize: 17),
                                            ),
                                            Text(
                                              location.phone ?? 'NO Street',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                      color: AppColor
                                                          .blodbrownText,
                                                      fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                    ),
                    Center(
                        child: CustomButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('locationdetails');
                      },
                      text: AppStrings.addNewAddress.tr(),
                      width: screenWidth * 0.6,
                    ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
