import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/service/categories_service.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_hand_craf_detail_bloc/get_hand_craft_detail_event.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_hand_craf_detail_bloc/get_hand_craft_detail_state.dart';

import '../../../../../core/domin/model/categories_model/get_hand_craftdetail_model.dart';

class GetHandCraftDetailBloc
    extends Bloc<GetHandCraftDetailEvent, GetHandCraftDetailState> {
  GetHandCraftDetailBloc() : super(GetHandCraftDetailInitial()) {
    on<GetHandCraftDetailSuccessEvent>((event, emit) async {
      emit(GetHandCraftDetailLoadingState());
      try {
        var handcraft = await CategoriesImpl().detailByHandCraft(event.id);
        print(handcraft);
        GetHandCraftdetailModel data =
            GetHandCraftdetailModel.fromMap((handcraft['data']));
        emit(GetHandCraftDetailSuccessState(handcraft: data));
        print('------------------------------------------');
        print(data);
      } catch (e) {
        print(e.toString());
        emit(GetHandCraftDetailFieldState());
      }
    });
  }
}
