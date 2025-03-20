// ignore_for_file: library_private_types_in_public_api

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/home/screen/homepage.dart';
import 'package:hand_made_app/feature/home/screen/odrer_screen.dart';
import 'package:hand_made_app/feature/home/screen/setting_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedindex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  var screen = [
    const HomepageScreen(),
    const OrderScreen(),
    const SettingScreen(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screen[selectedindex],
          Positioned(
              bottom: 10,
              left: 30,
              right: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor
                      .background, // Set the background color to match the page
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BottomNavigationBar(
                    key: _bottomNavigationKey,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: AppStrings.home.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.shopping_cart),
                        label: AppStrings.order.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.settings),
                        label: AppStrings.setting.tr(),
                      ),
                    ],
                    currentIndex: selectedindex,
                    unselectedItemColor: AppColor.brownText,
                    selectedItemColor: AppColor.primary,
                    backgroundColor: AppColor.background,
                    elevation: 8, // Add elevation for the shadow effect
                    onTap: _onItemTapped,
                  ),
                ),
                // index: 0,
                // height: 50.0,
                // items: <Widget>[
                //   Icon(
                //     Icons.home,
                //     color: AppColor.background,
                //   ),
                //   Icon(
                //     Icons.groups,
                //     color: AppColor.background,
                //   ),
                //   Icon(
                //     Icons.shopping_cart,
                //     color: AppColor.background,
                //   ),
                //   Icon(
                //     Icons.settings,
                //     color: AppColor.background,
                //   ),
                // ],
                // buttonBackgroundColor: AppColor.primary,
                // backgroundColor: Colors.transparent,
                // color: AppColor.primary,
                // animationCurve: Curves.easeInOut,
                // animationDuration: const Duration(milliseconds: 400),
                // onTap: (index) {
                //   setState(() {
                //     selectedindex = index;
                //   });
                // },
                // letIndexChange: (index) => true,
              )),
        ],
      ),
    );
  }
}
