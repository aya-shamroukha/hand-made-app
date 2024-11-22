// ignore_for_file: library_private_types_in_public_api

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/auth/screen/login_screen.dart';
import 'package:hand_made_app/feature/auth/screen/signup_screen.dart';
import 'package:hand_made_app/feature/home/screen/homepage.dart';
import 'package:hand_made_app/feature/home/screen/setting_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedindex = 0;
  var screen = [
    const HomepageScreen(),
    const LoginScreen(),
    const SignupScreen(),
    const SettingScreen()
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screen[selectedindex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 50.0,
              items: <Widget>[
                Icon(
                  Icons.home,
                  color: AppColor.background,
                ),
                Icon(
                  Icons.groups,
                  color: AppColor.background,
                ),
                Icon(
                  Icons.shopping_cart,
                  color: AppColor.background,
                ),
                Icon(
                  Icons.settings,
                  color: AppColor.background,
                ),
              ],
              buttonBackgroundColor: AppColor.primary,
              backgroundColor: Colors.transparent,
              color: AppColor.primary,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 400),
              onTap: (index) {
                setState(() {
                  selectedindex = index;
                });
              },
              letIndexChange: (index) => true,
            ),
          ),
        ],
      ),
    );
  }
}
