import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/add_new_comment/add_new_comment_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import '../../share/custom_text_field.dart';
import '../../share/sized_box.dart';
import '../bloc/add_new_comment/add_new_comment_state.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });

  final TextEditingController comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewCommentBloc()
        ..add(GetCommentSuccessEvent(
            id: getIt.get<SharedPreferences>().getInt(
                  'id details',
                ))),
      child: BlocBuilder<AddNewCommentBloc, AddNewCommentState>(
          builder: (context, state) {
        if (state is GetCommentSuccessState) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: 300.w,
                        height: 350.h,
                        decoration: BoxDecoration(
                            color: AppColor.lightbrownText.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 270.h,
                              width: double.maxFinite,
                              child: ListView.builder(
                                  //shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.getcomment.length,
                                  itemBuilder: (context, index) {
                                    if (state.getcomment.isEmpty) {
                                      return const Text('No Comment yet');
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 70.h,
                                        width: 140.h,
                                        child: ListTile(
                                          title: Text(state
                                              .getcomment[index].customer_name),
                                          leading: Container(
                                            width: 30.w,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                                color: AppColor.lightbrownText
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Icon(
                                              Icons.person,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                          subtitle: Text(state
                                              .getcomment[index].description),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 245.w,
                                  height: 60.h,
                                  child: CustomTextfield(
                                      controller: comment,
                                      labeltext: 'Add Comment'),
                                ),
                                //  stat is AddNewCommentLoadingState
                                //     ? const Loading()
                                InkWell(
                                  onTap: () {
                                    // context.read<AddNewCommentBloc>().add(
                                    //     AddNewCommentSuccessEvent(
                                    //         addComment: AddCommentModel(
                                    //             new_account: 43,
                                    //             clothes: state.clothes.id,
                                    //             description: comment.texclothest)));
                                    // context.read<GetClothesByIdBloc>().add(
                                    //     GetClothesByIdSuccessEvent(
                                    //         id: getIt
                                    //             .get<SharedPreferences>()
                                    //             .getInt(
                                    //               'id_details',
                                    //             )));
                                  },
                                  child: Container(
                                    width: 30.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        color: AppColor.lightbrownText
                                            .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Row(
              children: [
                SizedBox_width(width: 10.w),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Icon(
                    Icons.comment_outlined,
                    color: AppColor.primary,
                  ),
                ),
                // CustomText(
                //   horizontal: 5,
                //   text: AppStrings.comment,
                //   color: AppColor.primary,
                // ),
              ],
            ),
          );
        } else {
          return Row(
            children: [
              SizedBox_width(width: 10.w),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: Icon(
                  Icons.comment_outlined,
                  color: AppColor.primary,
                ),
              ),
              // CustomText(
              //   horizontal: 5,
              //   text: 'NO comment yet',
              //   color: AppColor.primary,
              // ),
            ],
          );
        }
      }),
    );
  }
}
