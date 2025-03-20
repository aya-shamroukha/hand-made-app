import '../../../../core/domin/model/categories_model/get_comment_model.dart';

class AddNewCommentState {}

final class AddNewCommentInitial extends AddNewCommentState {}

class AddNewCommentSuccessState extends AddNewCommentState {}

class AddNewCommentLoadingState extends AddNewCommentState {}

class AddNewCommentFieldState extends AddNewCommentState {}

class GetCommentSuccessState extends AddNewCommentState {
  final List<GetCommentModel> getcomment;

  GetCommentSuccessState({required this.getcomment});
}

class GetCommentLoadingState extends AddNewCommentState {}

class GetCommentFieldState extends AddNewCommentState {}
