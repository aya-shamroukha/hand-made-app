import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domin/model/categories_model/get_rating_model.dart';
import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_string.dart';
import '../bloc/get_rating_bloc/get_rating_bloc.dart';
import '../bloc/get_rating_bloc/get_rating_event.dart';

class RowForRating extends StatelessWidget {
  const RowForRating({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    double selectedRating = 0.0;

    return Row(
      children: [
        RatingBar.builder(
          unratedColor: AppColor.lightbrownText,
          initialRating: rating.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30, // Size of the stars
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: AppColor.primary, // Color of the stars
          ),
          onRatingUpdate: (newRating) {
            selectedRating = newRating.toDouble();
          },
          ignoreGestures: true, // Disable user interaction
        ),
        TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: AppColor.background,
                    title: Text(
                      AppStrings.addratingtext.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: AppColor.primary),
                    ),
                    content: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      // allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40,
                      unratedColor: AppColor.lightbrownText,

                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppColor.primary,
                      ),
                      onRatingUpdate: (rating) {
                        selectedRating = rating.toDouble();
                        print(selectedRating);
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.cancel.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: AppColor.blodbrownText),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<GetRatingBloc>().add(AddRatingEvent(
                                  getRatingModel: AddRatingModel(
                                stars: selectedRating.toInt(),
                                handcraft: getIt
                                    .get<SharedPreferences>()
                                    .getInt('id details')!
                                    .toInt(),
                              )));
                          Future.delayed(const Duration(seconds: 1), () {
                            context
                                .read<GetRatingBloc>()
                                .add(GetRatingSuccessEvent(
                                    id: getIt.get<SharedPreferences>().getInt(
                                          'id details',
                                        )));
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          AppStrings.addrating.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: AppColor.primary),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              AppStrings.addrating.tr(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColor.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decorationColor: AppColor.primary,
                    decoration: TextDecoration.underline,
                  ),
            ))
        // ... existing code ...
      ],
    );
  }
}
