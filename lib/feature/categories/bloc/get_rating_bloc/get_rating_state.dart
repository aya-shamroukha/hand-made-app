 import '../../../../core/domin/model/categories_model/get_rating_model.dart';

class GetRatingState {}

final class GetRatingInitial extends GetRatingState {}
class GetRatingSuccessState extends GetRatingState {
  final dynamic rating;

 GetRatingSuccessState({required this.rating});
}

class GetRatingLoadingState extends GetRatingState {}

class GetRatingFieldState extends GetRatingState {}