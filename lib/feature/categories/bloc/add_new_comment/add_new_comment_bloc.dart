// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/model/categories_model/get_comment_model.dart';
import 'package:hand_made_app/core/domin/service/categories_service.dart';

import 'add_new_comment_event.dart';
import 'add_new_comment_state.dart';

class AddNewCommentBloc extends Bloc<AddNewCommentEvent, AddNewCommentState> {
  AddNewCommentBloc() : super(AddNewCommentInitial()) {
    on<GetCommentSuccessEvent>((event, emit) async {
      emit(GetCommentLoadingState());
      try {
        final isSuccess = await CategoriesImpl().getComment(event.id);
        print('----------------');
        print(isSuccess);
        List<GetCommentModel> comment = List.generate(isSuccess['data'].length,
            (index) => GetCommentModel.fromMap((isSuccess['data'][index])));

        emit(GetCommentSuccessState(getcomment: comment));
      } catch (e) {
        print(e.toString());
        emit(GetCommentFieldState());
      }
    });
    on<AddNewCommentSuccessEvent>(
      (event, emit) async {
        emit(AddNewCommentLoadingState());
        try {
          final isSuccess = await CategoriesImpl().addComment(event.addComment);
          print('----------------');
          print(isSuccess);

          emit(AddNewCommentSuccessState());
        } catch (e) {
          print(e.toString());
          emit(AddNewCommentFieldState());
        }
      },
    );
  }
}
