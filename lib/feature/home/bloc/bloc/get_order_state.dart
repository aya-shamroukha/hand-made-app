import '../../../../core/domin/model/order_model/get_order_model.dart';

class GetOrderState {}

final class GetOrderInitial extends GetOrderState {}

class GetOrderSuccessState extends GetOrderState {
  final List<GetOrderModel> order;

  GetOrderSuccessState({required this.order});
}

class GetOrderLosdingState extends GetOrderState {}

class GetOrderFieldState extends GetOrderState {}
