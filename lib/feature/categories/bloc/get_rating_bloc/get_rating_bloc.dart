import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/feature/categories/bloc/get_rating_bloc/get_rating_state.dart';

import '../../../../core/domin/service/categories_service.dart';
import 'get_rating_event.dart';

class GetRatingBloc extends Bloc<GetRatingEvent, GetRatingState> {
  GetRatingBloc() : super(GetRatingInitial()) {
    on<GetRatingSuccessEvent>((event, emit) async {
      emit(GetRatingLoadingState());
      try {
        var rating = await CategoriesImpl().getRating(event.id);
        print(rating);
        dynamic ratingg = rating['data'] as dynamic;
        emit(GetRatingSuccessState(rating: ratingg));
        print('------------------------------------------');
        print(ratingg);
      } catch (e) {
        print(e.toString());
        emit(GetRatingFieldState());
      }
    });
    on<AddRatingEvent>(
      (event, emit) async {
        emit(AddRatingLoadingState());
        try {
          var rating = await CategoriesImpl().addRating(event.getRatingModel);
          print(rating);

          emit(AddRatingSuccessState());
          print('------------------------------------------');
        } catch (e) {
          print(e.toString());
          emit(AddRatingFieldState());
        }
      },
    );
  }
}
