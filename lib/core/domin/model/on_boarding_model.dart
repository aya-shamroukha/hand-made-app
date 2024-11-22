import 'package:easy_localization/easy_localization.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_string.dart';

class OnBoradingModel {
  final String imagPath;
  final String title;
  final String subtitle;

  OnBoradingModel(
      {required this.imagPath, required this.title, required this.subtitle});
  static List<OnBoradingModel> onBoradingScreen = [
    OnBoradingModel(
        imagPath: AppAssets.on1,
        title: AppStrings.on1title.tr(),
        subtitle: AppStrings.on1subtitle.tr()),
    OnBoradingModel(
        imagPath: AppAssets.on2,
        title: AppStrings.on2title.tr(),
        subtitle: AppStrings.on2subtitle.tr()),
    OnBoradingModel(
        imagPath: AppAssets.on3,
        title: AppStrings.on3title.tr(),
        subtitle: AppStrings.on3subtitle.tr())
  ];
}
