class GetRatingEvent {}

class GetRatingSuccessEvent extends GetRatingEvent {
  final dynamic id;

  GetRatingSuccessEvent({required this.id});
}
