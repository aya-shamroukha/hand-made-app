
import '../../../../core/domin/model/categories_model/add_comment_model.dart';

class AddNewCommentEvent {}

class AddNewCommentSuccessEvent extends AddNewCommentEvent {
  final AddCommentModel addComment;

  AddNewCommentSuccessEvent({required this.addComment});
}

class GetCommentSuccessEvent extends AddNewCommentEvent {
  final dynamic id;

  GetCommentSuccessEvent({required this.id});
}
