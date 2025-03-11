// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_color.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/home/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/image_picker_bloc/image_picker_event.dart';
import 'package:hand_made_app/feature/home/widget/my_row_imagepiker.dart';
import 'package:hand_made_app/feature/share/positioned_for_icon.dart';
import 'package:hand_made_app/feature/share/sized_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/image_picker_bloc/image_picker_state.dart';
import '../../widget/dialog_for_image.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ImagePickerBloc()..add(GetImage()),
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          var pikerbloc = BlocProvider.of<ImagePickerBloc>(context);
          return Scaffold(
            body: Stack(
              children: [
                PositionedForIcon(
                  icon: Icons.arrow_back,
                  left: 0,
                  top: screenHeight * 0.04,
                  iconColor: AppColor.blodbrownText,
                  color: AppColor.brownText,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: screenHeight * 0.5,
                    width: screenWidth * 1,
                    decoration: BoxDecoration(
                        color: AppColor.brownText,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70),
                        )),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.28,
                  left: screenWidth * 0.06,
                  child: Center(
                    child: Image.asset('assets/images/v.png'),
                  ),
                ),
                Positioned(
                    bottom: screenHeight * 0.5,
                    right: screenWidth * 0.03,
                    child: IconButton(
                        color: AppColor.brownText,
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                          AppColor.primary,
                        )),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogForImage(
                                    screenHeight: screenHeight);
                              });
                        },
                        icon: Icon(
                          Icons.attach_file,
                          color: AppColor.background,
                          size: 20,
                        ))),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 199.h,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    width: 250.w,
                    child: pikerbloc.imagePath == null
                        ? const Text('')
                        : Image.file(
                            File(pikerbloc.imagePath!),
                            fit: BoxFit.cover,
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


//   Future<dynamic> showDialogForImage(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               content: SizedBox(
//                   height: screenHeight * 0.5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                           child: Icon(
//                         Icons.warning,
//                         color: AppColor.primary,
//                         size: 30,
//                       )),
//                       Text(
//                         AppStrings.instructionsForTakePhoto.tr(),
//                         style: Theme.of(context).textTheme.displayMedium,
//                       ),
//                       SizedBox_Height(
//                         height: screenHeight * 0.03,
//                       ),
//                       CoustomRow(
//                         icon: Icons.photo,
//                         string: AppStrings.fromGallery.tr(),
//                         ontap: () {
//                           context
//                               .read<ImagePickerBloc>()
//                               .add(UploadImagegallery());
//                         },
//                       ),
//                       SizedBox_Height(
//                         height: 10.w,
//                       ),
//                       CoustomRow(
//                         icon: Icons.camera_alt,
//                         string: AppStrings.fromcamera.tr(),
//                         ontap: () {
//                           context
//                               .read<ImagePickerBloc>()
//                               .add(UploadImageGalleryCamera());
//                         },
//                       ),
//                       // SizedBox_Height(
//                       //   height: 10.w,
//                       // ),
//                       // CoustomRow(
//                       //   icon: Icons.delete_forever,
//                       //   string: AppStrings.deleteimage.tr(),
//                       //   ontap: deleteImage,
//                       // ),
//                     ],
//                   )));
//         });
//   }
// }
