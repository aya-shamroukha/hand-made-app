import '../../../../core/domin/model/categories_model/get_hand_craftdetail_model.dart';

class AddToCartEvent {}

class AddToCartSuccessEvent extends AddToCartEvent {
  final GetHandCraftdetailModel handcraft;
  AddToCartSuccessEvent({required this.handcraft});
}

class GetCartEvent extends AddToCartEvent {}

class RemoveFromcartEvent extends AddToCartEvent {
  final dynamic id;

  RemoveFromcartEvent({required this.id});
}

class DeleteFromcartEvent extends AddToCartEvent {
  final dynamic id;

  DeleteFromcartEvent({required this.id});
}
