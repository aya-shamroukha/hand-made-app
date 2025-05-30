// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/resources/app_assets.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/share/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../../core/domin/model/categories_model/add_comment_model.dart';
import '../../../core/domin/model/categories_model/updaete_comment_model.dart';
import '../../../core/resources/app_color.dart';
import '../../share/shimmer_body.dart';
import '../../share/sized_box.dart';
import '../bloc/add_new_comment/add_new_comment_bloc.dart';
import '../bloc/add_new_comment/add_new_comment_event.dart';
import '../bloc/add_new_comment/add_new_comment_state.dart';
import '../widget/bottomSheet_forcomment.dart';

// ignore: must_be_immutable
class CommentScreen extends StatefulWidget {
  CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  int? editingCommentId;
  Map<int, TextEditingController> editingControllers = {};

  @override
  void dispose() {
    comment.dispose();
    editingControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AddNewCommentBloc()
        ..add(GetCommentSuccessEvent(
            id: getIt.get<SharedPreferences>().getInt(
                  'id details',
                ))),
      child: Builder(builder: (context) {
        return SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                //!appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.comment,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.09,
                    ),
                    SizedBox_width(width: 7.w),
                    Text(
                      AppStrings.comment.tr(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    color: AppColor.lightbrownText,
                  ),
                ),
                BlocConsumer<AddNewCommentBloc, AddNewCommentState>(
                  listener: (context, state) {
                    if (state is DeleteCommentSuccessState) {
                      showTost(
                          message: AppStrings.deleted.tr(),
                          state: ToastState.success);
                      context.read<AddNewCommentBloc>().add(
                            GetCommentSuccessEvent(
                              id: getIt
                                  .get<SharedPreferences>()
                                  .getInt('id details'),
                            ),
                          );
                    } else if (state is DeleteCommentErrorState) {
                      showTost(
                          message: AppStrings.somethingwentwrong.tr(),
                          state: ToastState.error);
                    } else if (state is UpdateCommentSuccessState) {
                      showTost(
                          message: AppStrings.updated.tr(),
                          state: ToastState.success);
                      context.read<AddNewCommentBloc>().add(
                            GetCommentSuccessEvent(
                              id: getIt
                                  .get<SharedPreferences>()
                                  .getInt('id details'),
                            ),
                          );
                      setState(() {
                        editingCommentId = null;
                      });
                    } else if (state is UpdateCommentErrorState) {
                      showTost(
                          message: AppStrings.somethingwentwrong.tr(),
                          state: ToastState.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetCommentSuccessState) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.73,
                            child: state.getcomment.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.getcomment.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      final commentItem =
                                          state.getcomment[index];
                                      if (!editingControllers
                                          .containsKey(commentItem.id)) {
                                        editingControllers[commentItem.id] =
                                            TextEditingController(
                                                text: commentItem.description);
                                      }
                                      final textController =
                                          editingControllers[commentItem.id]!;
                                      return GestureDetector(
                                        onLongPress: () {
                                          showMenu(
                                            items: [
                                              PopupMenuItem(
                                                onTap: () {
                                                  setState(() {
                                                    editingCommentId =
                                                        commentItem.id;
                                                  });
                                                },
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.edit,
                                                    color: AppColor.primary,
                                                    size: 17,
                                                  ),
                                                  title: Text(
                                                    AppStrings.update.tr(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color:
                                                                AppColor.brown),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.delete,
                                                    color: AppColor.primary,
                                                    size: 17,
                                                  ),
                                                  title: Text(
                                                    AppStrings.delete.tr(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            color:
                                                                AppColor.brown),
                                                  ),
                                                ),
                                                onTap: () {
                                                  context
                                                      .read<AddNewCommentBloc>()
                                                      .add(DeleteCommentEvent(
                                                          id: commentItem.id));
                                                },
                                              )
                                            ],
                                            color: AppColor.background,
                                            context: context,
                                            position:
                                                const RelativeRect.fromLTRB(
                                                    50, 100, 100, 100),
                                          );
                                        },
                                        child: ListTile(
                                          trailing: Text(
                                            commentItem.date,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                    fontSize: 13,
                                                    color:
                                                        AppColor.blodbrownText),
                                          ),
                                          title: Text(
                                            commentItem.customer_name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(fontSize: 19),
                                          ),
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
                                          subtitle: SizedBox(
                                            width: 100,
                                            // height: 120,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (editingCommentId ==
                                                    commentItem.id)
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.55,
                                                        height:
                                                            screenHeight * 0.05,
                                                        child: TextFormField(
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .always,
                                                          enableInteractiveSelection:
                                                              true,
                                                          autofocus: true,
                                                          // showCursor: true,
                                                          cursorColor:
                                                              AppColor.primary,
                                                          controller:
                                                              textController,
                                                          decoration: InputDecoration(
                                                              border: InputBorder
                                                                  .none,
                                                              enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: AppColor
                                                                          .primary)),
                                                              errorBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: AppColor
                                                                          .primary)),
                                                              focusedBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: AppColor
                                                                          .primary)),
                                                              hintText:
                                                                  AppStrings
                                                                      .addcomment
                                                                      .tr(),
                                                              filled: false),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              if (textController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                context.read<AddNewCommentBloc>().add(
                                                                    UpdateCommentEvent(
                                                                        commentId:
                                                                            commentItem
                                                                                .id,
                                                                        model:
                                                                            UpdaeteCommentModel(
                                                                          date:
                                                                              DateTime.now().toString(),
                                                                          description:
                                                                              textController.text,
                                                                          handcraft:
                                                                              commentItem.handcraft,
                                                                          time:
                                                                              DateTime.now().toString(),
                                                                        )));
                                                              }
                                                            },
                                                            child: Text(
                                                              AppStrings.update
                                                                  .tr(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displaySmall!
                                                                  .copyWith(
                                                                      decorationColor:
                                                                          AppColor
                                                                              .primary,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      color: AppColor
                                                                          .primary),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  Text(
                                                    commentItem.description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: AppColor
                                                                .blodbrownText),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      SizedBox_Height(
                                          height: screenHeight * 0.3),
                                      Image.asset(
                                        AppAssets.nocomment,
                                        width: 70,
                                      ),
                                      Text(
                                        AppStrings.nocomment.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox_Height(height: 10.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              color: AppColor.lightbrownText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: screenWidth * 0.7,
                                height: screenHeight * 0.05,
                                decoration: BoxDecoration(
                                    color: AppColor.lightbrownText
                                        .withOpacity(0.6),
                                    border: Border.all(
                                        color: AppColor.lightbrownText),
                                    borderRadius: BorderRadius.circular(30)),
                                child: SizedBox(
                                  width: screenWidth * 0.55,
                                  height: screenHeight * 0.05,
                                  child: TextFormField(
                                    validator: (val) => val?.isEmpty ?? true
                                        ? AppStrings.notexthere.tr()
                                        : null,
                                    cursorColor: AppColor.primary,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: AppStrings.addcomment.tr(),
                                        filled: false),
                                    controller: comment,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  if (globalKey.currentState!.validate()) {
                                    final newComment = comment.text;
                                    comment.clear();

                                    context.read<AddNewCommentBloc>().add(
                                        AddNewCommentSuccessEvent(
                                            addComment: AddCommentModel(
                                                time: DateTime.now().toString(),
                                                date: DateTime.now().toString(),
                                                description: newComment,
                                                handcraft: getIt
                                                    .get<SharedPreferences>()
                                                    .getInt('id details'))));

                                    await Future.delayed(
                                        const Duration(milliseconds: 300));
                                    context.read<AddNewCommentBloc>().add(
                                        GetCommentSuccessEvent(
                                            id: getIt
                                                .get<SharedPreferences>()
                                                .getInt('id details')));
                                  }
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.lightbrownText),
                                      color: AppColor.lightbrownText
                                          .withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(100)),
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
                      );
                    } else {
                      return SizedBox(
                        height: screenHeight * 0.7,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerBodyForImage(
                                    height: screenHeight * 0.07,
                                    width: screenWidth * 0.8,
                                  ),
                                ),
                              );
                            })),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )));
      }),
    );
  }
}
  // showModalBottomSheet(
                                                  //   context: context,
                                                  //   backgroundColor:
                                                  //       AppColor.background,
                                                  //   builder: (context) {
                                                  //     return BottomSheetForComment(
                                                  //       controller:
                                                  //           textController,
                                                  //       //    textController: textController,
                                                  //       onPressedupdate:
                                                  //           () async {
                                                  //         print(textController
                                                  //             .text);
                                                  //         context.read<AddNewCommentBloc>().add(UpdateCommentEvent(
                                                  //             commentId: state
                                                  //                 .getcomment[
                                                  //                     index]
                                                  //                 .id,
                                                  //             model: UpdaeteCommentModel(
                                                  //                 date: DateFormat
                                                  //                         .yMd()
                                                  //                     .format(DateTime
                                                  //                         .now())
                                                  //                     .toString(),
                                                  //                 description:
                                                  //                     textController
                                                  //                         .text
                                                  //                         .toString(),
                                                  //                 handcraft: state
                                                  //                     .getcomment[
                                                  //                         index]
                                                  //                     .handcraft,
                                                  //                 time: DateFormat
                                                  //                         .Hm()
                                                  //                     .format(DateTime.now())
                                                  //                     .toString())));
                                                  //         await Future.delayed(
                                                  //             const Duration(
                                                  //                 milliseconds:
                                                  //                     300));

                                                  //         // context
                                                  //         //     .read<
                                                  //         //         AddNewCommentBloc>()
                                                  //         //     .add(GetCommentSuccessEvent(
                                                  //         //         id: getIt
                                                  //         //             .get<
                                                  //         //                 SharedPreferences>()
                                                  //         //             .getInt(
                                                  //         //                 'id details')));
                                                  //         Navigator.pop(
                                                  //             context);
                                                  //         Navigator.pop(
                                                  //             context);
                                                  //       },
                                                  //       onPressed: () async {
                                                  //         context
                                                  //             .read<
                                                  //                 AddNewCommentBloc>()
                                                  //             .add(DeleteCommentEvent(
                                                  //                 id: state
                                                  //                     .getcomment[
                                                  //                         index]
                                                  //                     .id));
                                                  //         await Future.delayed(
                                                  //             const Duration(
                                                  //                 milliseconds:
                                                  //                     300));
                                                  //         // context
                                                  //         //     .read<
                                                  //         //         AddNewCommentBloc>()
                                                  //         //     .add(GetCommentSuccessEvent(
                                                  //         //         id: getIt
                                                  //         //             .get<
                                                  //         //                 SharedPreferences>()
                                                  //         //             .getInt(
                                                  //         //                 'id details')));
                                                  //         Navigator.pop(
                                                  //             context);
                                                  //       },
                                                  //       id: state
                                                  //           .getcomment[index]
                                                  //           .id,
                                                  //       text: state
                                                  //           .getcomment[index]
                                                  //           .description,
                                                  //     );