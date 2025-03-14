import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/config/theme/theme.dart';
import 'package:hand_made_app/feature/auth/screen/change_lan.dart';
import 'package:hand_made_app/feature/auth/screen/check_code_screen.dart';
import 'package:hand_made_app/feature/auth/screen/forget_password_screen.dart';
import 'package:hand_made_app/feature/auth/screen/login_screen.dart';
import 'package:hand_made_app/feature/auth/screen/new_password_screen.dart';
import 'package:hand_made_app/feature/auth/screen/signup_screen.dart';
import 'package:hand_made_app/feature/home/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:hand_made_app/feature/home/screen/bottom_bar.dart';
import 'package:hand_made_app/feature/home/screen/categories_screen/categories_by_id.dart';
import 'package:hand_made_app/feature/home/screen/categories_screen/categories_details.dart';
import 'package:hand_made_app/feature/home/screen/location_screen.dart';
import 'package:hand_made_app/feature/home/screen/setting_screen.dart';
import 'package:hand_made_app/feature/on_boarding/on_boarding.dart';
import 'package:hand_made_app/feature/on_boarding/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'feature/home/bloc/image_picker_bloc/image_picker_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initgetit();
  getIt.get<SharedPreferences>().getString(
        'languagecode',
      );
  getCurrentLocationApp();
  runApp(EasyLocalization(
      path: "assets/translation",
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: BlocProvider(
        create: (context) => ImagePickerBloc()..add(GetImage()),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const SplashScreen(),
            routes: {
              'location': (context) => const LocationScreen(),
              'login': (context) => const LoginScreen(),
              'setting': (context) => const SettingScreen(),
              'onboaring': (context) => OnBoaringScreens(),
              'signup': (context) => const SignupScreen(),
              'bottom': (context) => const BottomNavBar(),
              'categoriesdetails': (context) => const CategoriesDetails(),
              'ChangeLangScreen': (context) => const ChangeLangScreen(),
              'checkcode': (context) => CheckCodeScreen(),
              'newpassword': (context) => const NewPasswordScreen(),
              'categoriesbyid': (context) => const CategoriesById(),
              'forgetpassword': (context) => const ForgetPasswordScreen()
            },
          );
        });
  }
}
