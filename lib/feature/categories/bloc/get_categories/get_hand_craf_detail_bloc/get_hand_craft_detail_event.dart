 class GetHandCraftDetailEvent {}
class GetHandCraftDetailSuccessEvent extends GetHandCraftDetailEvent {
  final dynamic id;

 GetHandCraftDetailSuccessEvent({required this.id});
}
