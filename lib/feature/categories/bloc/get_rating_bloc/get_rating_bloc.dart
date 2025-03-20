import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_state.dart';

import '../../../../core/domin/model/categories_model/get_rating_model.dart';
import '../../../../core/domin/service/categories_service.dart';
import 'get_rating_event.dart';

class GetRatingBloc extends Bloc<GetRatingEvent, GetRatingState> {
  GetRatingBloc() : super(GetRatingInitial()) {
    on<GetRatingSuccessEvent>((event, emit) async {
      emit(GetRatingLoadingState());
      try {
        var rating = await CategoriesImpl().getRating(event.id);
        print(rating);
        double ratingg = rating['data']as double;
        emit(GetRatingSuccessState(rating: ratingg));
        print('------------------------------------------');
        print(ratingg);
      } catch (e) {
        print(e.toString());
        emit(GetRatingFieldState());
      }
    });
  }
}
