import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/model/order_model/get_order_model.dart';
import 'package:hand_made_app/core/domin/service/order_service.dart';
import 'package:hand_made_app/feature/order/bloc/get_order_bloc/get_order_event.dart';
import 'package:hand_made_app/feature/order/bloc/get_order_bloc/get_order_state.dart';


class GetOrderBloc extends Bloc<GetOrderEvent, GetOrderState> {
  GetOrderBloc() : super(GetOrderInitial()) {
    on<GetOrderSuccessEvent>((event, emit) async {
      emit(GetOrderLosdingState());
      try {
        var getorder =
            await OrderImpl().getOrder();

        List<GetOrderModel> order = List.generate(
            getorder['data'].length,
            (index) =>
                GetOrderModel.fromMap((getorder['data'][index])));
        emit(GetOrderSuccessState(order: order));

        // Removed redundant emission of success state
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetOrderFieldState());
      }
    });
  }
}
