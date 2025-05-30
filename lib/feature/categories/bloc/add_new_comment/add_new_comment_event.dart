
import '../../../../core/domin/model/categories_model/add_comment_model.dart';
import '../../../../core/domin/model/categories_model/updaete_comment_model.dart';

class AddNewCommentEvent {}

class AddNewCommentSuccessEvent extends AddNewCommentEvent {
  final AddCommentModel addComment;

  AddNewCommentSuccessEvent({required this.addComment});
}

class GetCommentSuccessEvent extends AddNewCommentEvent {
  final dynamic id;

  GetCommentSuccessEvent({required this.id});
}

class DeleteCommentEvent extends AddNewCommentEvent {
 final dynamic id;
  DeleteCommentEvent({required this.id});
}

class UpdateCommentEvent extends AddNewCommentEvent {
  final dynamic commentId;
  final UpdaeteCommentModel model;

  UpdateCommentEvent({
    required this.commentId,
    required this.model,
  });
}
