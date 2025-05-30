// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/model/categories_model/get_categories_model.dart';
import 'package:hand_made_app/core/domin/service/categories_service.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_categories_bloc/get_categories_event.dart';
import 'package:hand_made_app/feature/categories/bloc/get_categories/get_categories_bloc/get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  GetCategoriesBloc() : super(GetCategoriesInitial()) {
    on<GetCategoriesSuccessEvent>((event, emit) async {
      emit(GetCategoriesLoadingState());
      try {
        var getcategories =
            await CategoriesImpl().getCategoriesForCustomerAndmMaker();

        List<GetCategoriesModel> categories = List.generate(
            getcategories['data'].length,
            (index) =>
                GetCategoriesModel.fromMap((getcategories['data'][index])));
        emit(GetCategoriesSuccessState(getCategories: categories));

        // Removed redundant emission of success state
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetCategoriesFieldState());
      }
    });
  }
}
