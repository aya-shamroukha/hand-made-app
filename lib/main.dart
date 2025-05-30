import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/config/theme/theme.dart';
import 'package:hand_made_app/feature/auction/screen/handcraft_byauction_screen.dart';
import 'package:hand_made_app/feature/auction/screen/maker_byauction_screen.dart';
import 'package:hand_made_app/feature/auth/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:hand_made_app/feature/auth/screen/change_lan.dart';
import 'package:hand_made_app/feature/auth/screen/check_code_screen.dart';
import 'package:hand_made_app/feature/auth/screen/forget_password_screen.dart';
import 'package:hand_made_app/feature/auth/screen/login_screen.dart';
import 'package:hand_made_app/feature/auth/screen/new_password_screen.dart';
import 'package:hand_made_app/feature/auth/screen/signup_screen.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_bloc.dart';
import 'package:hand_made_app/feature/categories/screen/ai_screen.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_event.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_bloc.dart';
import 'package:hand_made_app/feature/home/screen/address_screen.dart';
import 'package:hand_made_app/feature/home/screen/bottom_bar.dart';
import 'package:hand_made_app/feature/categories/screen/categories_by_id.dart';
import 'package:hand_made_app/feature/categories/screen/categories_details.dart';
import 'package:hand_made_app/feature/home/screen/discount_screen.dart';
import 'package:hand_made_app/feature/home/screen/location_details_screen.dart';
import 'package:hand_made_app/feature/home/screen/location_screen.dart';
import 'package:hand_made_app/feature/auction/screen/auction_screen.dart';
import 'package:hand_made_app/feature/home/screen/setting_screen.dart';
import 'package:hand_made_app/feature/on_boarding/on_boarding.dart';
import 'package:hand_made_app/feature/on_boarding/splash_screen.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_bloc.dart';
import 'package:hand_made_app/feature/order/screen/cart_screen.dart';
import 'package:hand_made_app/feature/order/screen/the_final_order_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/local_storage/sqflite.dart';
import 'core/resources/bloc_observer.dart';

import 'feature/categories/bloc/ai_bloc/ai_bloc_bloc.dart';
import 'feature/categories/bloc/ai_bloc/ai_bloc_event.dart';

import 'feature/categories/bloc/get_rating_bloc/get_rating_event.dart';

import 'feature/order/bloc/add_to_cart_bloc/add_to_cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  await initgetit();
  await getIt<Sqflite>().initDb();
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AddToCartBloc()),
          BlocProvider(create: (context) => AddOrderBloc()),
          BlocProvider(
            create: (context) => AiBlocBloc()..add(DownloadImageEvent()),
          ),
          BlocProvider(create: (context) => ResetPasswordBloc()),
          // BlocProvider(create: (context) => AddNewCommentBloc()),
          BlocProvider(
              create: (context) =>
                  AuctionBloc()..add(GetAuctionSuccessEvent())),
          BlocProvider(
            create: (context) => GetRatingBloc()
              ..add(GetRatingSuccessEvent(
                  id: getIt.get<SharedPreferences>().getInt(
                        'id details',
                      ))),
          ),
          BlocProvider(create: (context) => LocationDetailsBloc()),
        ],
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
              'location': (context) => LocationScreen(
                    fromCart: false,
                  ),
              'login': (context) => const LoginScreen(),
              'setting': (context) => const SettingScreen(),
              'onboaring': (context) => OnBoaringScreens(),
              'signup': (context) => const SignupScreen(),
              'bottom': (context) => const BottomNavBar(),
              'categoriesdetails': (context) => const CategoriesDetails(),
              'ChangeLangScreen': (context) => const ChangeLangScreen(),
              'checkcode': (context) => CheckCodeScreen(),
              'newpassword': (context) => NewPasswordScreen(),
              'categoriesbyid': (context) => const CategoriesById(),
              'forgetpassword': (context) => const ForgetPasswordScreen(),
              'ai': (context) => const Ai(),
              'auction': (context) => const AuctionScreen(),
              'cartscreen': (context) => const CartScreen(),
              'handauction': (context) => const HandcraftByauctionScreen(),
              'discount': (context) => const GetAllDiscountScreen(),
              'locationdetails': (context) => LocationDetailsScreen(
                    fromCart: false,
                  ),
              'address': (context) => AddressScreen(),
              'maker': (context) => const MakerByAuctionScreen(),
              'finalorder': (context) => const TheFinalOrderScreen()
            },
          );
        });
  }
}
