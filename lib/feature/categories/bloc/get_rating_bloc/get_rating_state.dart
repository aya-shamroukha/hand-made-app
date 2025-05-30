
class GetRatingState {}

final class GetRatingInitial extends GetRatingState {}
class GetRatingSuccessState extends GetRatingState {
  final dynamic rating;

 GetRatingSuccessState({required this.rating});
}

class GetRatingLoadingState extends GetRatingState {}

class GetRatingFieldState extends GetRatingState {}
class AddRatingSuccessState extends GetRatingState {
 
}

class  AddRatingLoadingState extends GetRatingState {}

class  AddRatingFieldState extends GetRatingState {}