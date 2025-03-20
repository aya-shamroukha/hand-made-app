 import '../../../../../core/domin/model/categories_model/get_hand_craftdetail_model.dart';

class GetHandCraftDetailState {}

final class GetHandCraftDetailInitial extends GetHandCraftDetailState {}
class GetHandCraftDetailSuccessState extends GetHandCraftDetailState {
  final GetHandCraftdetailModel handcraft;

 GetHandCraftDetailSuccessState({required this.handcraft});
}

class GetHandCraftDetailLoadingState extends GetHandCraftDetailState {}

class GetHandCraftDetailFieldState extends GetHandCraftDetailState {}
