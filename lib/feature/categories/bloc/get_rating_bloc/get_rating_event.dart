import 'package:hand_made_app/core/domin/model/categories_model/get_rating_model.dart';

class GetRatingEvent {}

class GetRatingSuccessEvent extends GetRatingEvent {
  final dynamic id;

  GetRatingSuccessEvent({required this.id});
}

class AddRatingEvent extends GetRatingEvent {
  final AddRatingModel getRatingModel;

  AddRatingEvent({required this.getRatingModel});
}
