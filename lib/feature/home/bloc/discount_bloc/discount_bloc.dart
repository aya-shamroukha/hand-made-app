

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/service/discount_service.dart';

import '../../../../core/domin/model/discount_model/discount_model.dart';
import 'discount_event.dart';
import 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc() : super(DiscountInitial()) {
    on<GetAllDiscountEvent>((event, emit) async{
    emit(GetAllDiscountLoadingState());
      try{
        var getdiscount = await DiscountImpl().getAllDiscount();
        
      print(getdiscount);
print(getdiscount['data']);
         
            List<DiscountModel> discount = List.generate(
                getdiscount['data'].length,
                (index) =>
                    DiscountModel.fromMap((getdiscount['data'][index])));
            emit(GetAllDiscountSuccessState(discount: discount));
          
       
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetAllDiscountFeildState());
      }
    });
  }
}
