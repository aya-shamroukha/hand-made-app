// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    bool isVisited =
        getIt.get<SharedPreferences>().getBool('onboarding') ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      isVisited
          ? Navigator.of(context).pushReplacementNamed("ChangeLangScreen")
          : Navigator.of(context).pushReplacementNamed("bottom");
    });
    Future.delayed(const Duration(seconds: 3), () async {
      getIt.get<SharedPreferences>().getString('token') == null
          ? Navigator.of(context).pushReplacementNamed("ChangeLangScreen")
          : Navigator.of(context).pushReplacementNamed("bottom");
      //GoRouter.of(context).go(Routes().changeLang);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.w,
              height: 300.h,
              child: Image.asset(
                AppAssets.splash,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
