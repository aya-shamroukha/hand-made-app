import 'package:hand_made_app/core/domin/model/categories_model/get_hand_craftdetail_model.dart';

class AddToCartState {
  List<Object> get props => [];
}

final class AddToCartInitial extends AddToCartState {
  @override
  List<Object> get props => [];
}

class AddToCartSuccessState extends AddToCartState {
  // final List<GetHandCraftdetailModel> cartItems;
  // @override
  // List<Object> get props => [];
  // AddToCartSuccessState({required this.cartItems});
}

class GetCartState extends AddToCartState {
  final List<GetHandCraftdetailModel> cartItems;

  GetCartState({required this.cartItems});
  @override
  List<Object> get props => [];
}

class RemoveFromCartSuccessState extends AddToCartState {
  final List<GetHandCraftdetailModel>? cartItems;
  RemoveFromCartSuccessState({this.cartItems});
}

class DeleteFromcartSuccessState extends AddToCartState {
  final List<GetHandCraftdetailModel>? cartItems;
  DeleteFromcartSuccessState({this.cartItems});
}
