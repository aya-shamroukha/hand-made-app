import 'package:hand_made_app/core/domin/model/order_model/add_order_model.dart';

class AddOrderEvent {}

class AddOrderSuccessEvent extends AddOrderEvent {
  final AddOrderModel addOrderModel;

  AddOrderSuccessEvent({required this.addOrderModel});
}
