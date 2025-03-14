import 'package:flutter/material.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox_Height(height: screenHeight * 0.03),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Icon(
            //         Icons.location_on,
            //         color: AppColor.primary,
            //         size: 30,
            //       ),
            // Text(
            //   getIt.get<SharedPreferences>().getString('address') == null
            //       ? 'My location'
            //       : '${getIt.get<SharedPreferences>().getString('address')}',
            //   style: Theme.of(context)
            //       .textTheme
            //       .displayMedium!
            //       .copyWith(color: AppColor.blodbrownText),
            // ),
            //     ],
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Container(
                  height: screenHeight * 0.17,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: AppColor.lightbrownText,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.brownText)),
                  child: Image.asset(
                    AppAssets.sale,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('categoriesbyid');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        height: screenHeight * 0.17,
                        width: screenWidth * 0.06,
                        decoration: BoxDecoration(
                            color: AppColor.lightbrownText,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.brownText)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'فازة لوضع الزهور',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Image.asset(
                                'assets/images/v.png',
                                width: screenWidth * 0.4,
                                height: screenHeight * 1,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
