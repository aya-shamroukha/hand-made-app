// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/feature/categories/bloc/ai_bloc/ai_bloc_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/ai_bloc/ai_bloc_event.dart';
import 'package:hand_made_app/feature/share/my_loading.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/app_color.dart';
import '../../../core/domin/model/ai_model/ai_model.dart';
import '../../../core/resources/app_string.dart';
import '../../home/widget/my_row_imagepiker.dart';
import '../../share/custom_button.dart';
import '../../share/positioned_for_icon.dart';
import '../../share/shimmer_body.dart';
import '../../share/toast.dart';
import '../bloc/ai_bloc/ai_bloc_state.dart';

class Ai extends StatefulWidget {
  const Ai({super.key});

  @override
  State<Ai> createState() => _AiState();
}

class _AiState extends State<Ai> {
  File? image;
  String? imagePath;
  final imagepicker = ImagePicker();
  //! upload image from gallery
  uploadimagegallery() async {
    var pickedimage2 = await imagepicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();

    if (pickedimage2 != null) {
      saveImage(pickedimage2.path.toString());
      setState(() {
        image = File(pickedimage2.path);
      });
    } else {}
  }

//! upload image from cameria
  uploadimagegallerycam() async {
    var pickedimage = await imagepicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    if (pickedimage != null) {
      saveImage(pickedimage.path.toString());
      setState(() {
        image = File(pickedimage.path);
      });
    } else {}
  }

//! save image with path
  saveImage(String val) async {
    final imageshared = await SharedPreferences.getInstance();
    imageshared.setString('path', val);
    getImage();
  }

//!get image from path
  getImage() async {
    final imageshared = await SharedPreferences.getInstance();
    setState(() {
      imagePath = imageshared.getString('path');
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
    deleteImage();
  }

//!delete image
  void deleteImage() async {
    final imageDel = await SharedPreferences.getInstance();
    imageDel.remove('path');
    getImage();
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<AiBlocBloc, AiBlocState>(
                listener: (context, state) {
      if (state is AiErrorState) {
        showTost(
            message: AppStrings.somethingwentwrong.tr(),
            state: ToastState.error);
      }
    }, builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox_width(
                  width: 100.w,
                ),
                PositionedForIcon(
                  top: screenHeight * 0.04,
                  onPressed: () {
                    deleteImage;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            // Center(
            //     child: Icon(
            //   Icons.warning,
            //   color: AppColor.primary,
            //   size: 30,
            // )),
            Text(
              AppStrings.instructionsForTakePhoto.tr(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox_Height(
              height: screenHeight * 0.01,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.background),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'يجب ان تكون وضعية الصورة بزاوية 90 ',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: AppColor.brown),
                              ),
                              SizedBox_Height(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.sofa,
                                    width: screenWidth * 0.3,
                                  ),
                                  Text(
                                    '  +  ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            color: AppColor.brown,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    AppAssets.pillow,
                                    width: screenWidth * 0.3,
                                  ),
                                ],
                              ),
                              Text(
                                '=',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: AppColor.brown,
                                        fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                AppAssets.ai,
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.1,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                AppStrings.example.tr(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    decorationColor: AppColor.primary,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox_Height(
              height: screenHeight * 0.03,
            ),
            CoustomRow(
                icon: Icons.photo,
                string: AppStrings.fromGallery.tr(),
                ontap: uploadimagegallery),
            SizedBox_Height(
              height: 10.w,
            ),
            CoustomRow(
                icon: Icons.camera_alt,
                string: AppStrings.fromcamera.tr(),
                ontap: uploadimagegallerycam),
            SizedBox_Height(height: 10.h),
            state is AiSuccessState
                ? Column(
                    children: [
                      SizedBox(
                        width: screenWidth * 1,
                        height: screenHeight * 0.3,
                        child: Image.network(
                          'http://199.192.19.220:5400${state.imageUrl}',
                          errorBuilder: (context, error, stackTrace) {
                            return Stack(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: ShimmerBodyForImage(
                                    height: screenHeight * 0.2.h,
                                    width: screenWidth * 0.4.w,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 30),
                                  child: Center(
                                      child: Text(
                                    ' تستغرق هذه العملية بضعة ثواني',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  )),
                                ),
                              ],
                            );
                          },
                          loadingBuilder: (context, error, stackTrace) {
                            if (stackTrace == null) {
                              return Image.network(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.02,
                                  fit: BoxFit.fill,
                                  'http://199.192.19.220:5400${state.imageUrl}');
                            } else {
                              return Stack(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: ShimmerBodyForImage(
                                      width: screenWidth * 1,
                                      height: screenHeight * 0.3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 30),
                                    child: Center(
                                        child: Text(
                                      ' تستغرق هذه العملية بضعة ثواني',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    )),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox_Height(height: 10.h),
                      CustomButton(
                        onPressed: () async {
                          deleteImage();
                          final downloadedImagePath =
                              getIt.get<SharedPreferences>().getString('image');

                          if (downloadedImagePath != null) {
                            // Create a MultipartFile from the downloaded image
                            final pillowImage = MultipartFile.fromFileSync(
                              downloadedImagePath,
                              filename: downloadedImagePath.split('/').last,
                            );

                            // Trigger the event with the downloaded image
                            context.read<AiBlocBloc>().add(
                                  AiEventSuccess(
                                    aiModel: AiModel(
                                      sofa_image: MultipartFile.fromFileSync(
                                        image!.path,
                                        filename: imagePath!.split('/').last,
                                      ),
                                      pillow_image:
                                          pillowImage, // Use the downloaded image here
                                    ),
                                  ),
                                );
                          } else {
                            print(
                                "Downloaded image path not found in SharedPreferences.");
                          }
                        },
                        text: AppStrings.tryagain.tr(),
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.4,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox_Height(height: 10.h),
                      imagePath == null
                          ? const Text('')
                          : Column(
                              children: [
                                Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.contain,
                                  width: screenWidth * 1,
                                  height: screenHeight * 0.25,
                                ),
                                SizedBox_Height(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    state is AiLoadingState
                                        ? const Loading()
                                        : CustomButton(
                                            onPressed: () async {
                                              final downloadedImagePath = getIt
                                                  .get<SharedPreferences>()
                                                  .getString('image');

                                              if (downloadedImagePath != null) {
                                                // Create a MultipartFile from the downloaded image
                                                final pillowImage =
                                                    MultipartFile.fromFileSync(
                                                  downloadedImagePath,
                                                  filename: downloadedImagePath
                                                      .split('/')
                                                      .last,
                                                );

                                                // Trigger the event with the downloaded image
                                                context.read<AiBlocBloc>().add(
                                                      AiEventSuccess(
                                                        aiModel: AiModel(
                                                          sofa_image:
                                                              MultipartFile
                                                                  .fromFileSync(
                                                            image!.path,
                                                            filename: imagePath!
                                                                .split('/')
                                                                .last,
                                                          ),
                                                          pillow_image:
                                                              pillowImage, // Use the downloaded image here
                                                        ),
                                                      ),
                                                    );
                                              } else {
                                                print(
                                                    "Downloaded image path not found in SharedPreferences.");
                                              }
                                            },
                                            text: 'موافق',
                                            height: screenHeight * 0.04,
                                            width: screenWidth * 0.3,
                                          ),
                                    CustomButton(
                                      onPressed: deleteImage,
                                      text: 'الغاء',
                                      height: screenHeight * 0.04,
                                      width: screenWidth * 0.3,
                                    ),
                                  ],
                                )
                              ],
                            )
                    ],
                  ),
          ]));
    })));
  }
}
