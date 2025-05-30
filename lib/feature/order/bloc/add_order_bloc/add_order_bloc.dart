import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/service/order_service.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_event.dart';
import 'package:hand_made_app/feature/order/bloc/add_order_bloc/add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  AddOrderBloc() : super(AddOrderInitial()) {
    on<AddOrderSuccessEvent>((event, emit) async {
      emit(AddOrderLoadingState());
      try {
        final order = await OrderImpl().addOrder(event.addOrderModel);
        print('----------------');
        print(order);
        if (order) {
          emit(AddOrderSuccessState());
        }
      } catch (e) {
        print(e.toString());
        emit(AddOrderFieldState());
      }
    });
  }
}
