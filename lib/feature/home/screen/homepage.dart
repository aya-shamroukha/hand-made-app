import 'package:flutter/material.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColor.primary,
                    size: 30,
                  ),
                  Text(
                    getIt.get<SharedPreferences>().getString('address') == null
                        ? 'My location'
                        : '${getIt.get<SharedPreferences>().getString('address')}',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColor.blodbrownText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
