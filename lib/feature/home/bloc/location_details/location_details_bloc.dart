import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/config/local_storage/sqflite.dart';
import 'package:hand_made_app/feature/home/bloc/location_details/location_details_state.dart';

import 'location_details_event.dart';

class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<LocationModel> list = [];
  LocationDetailsBloc() : super(LocationDetailsInitial()) {
    on<InsertDetailsEvent>((event, emit) async {
      emit(InsertDetailsLoadingState());
      try {
        await Future.delayed(const Duration(seconds: 1));
        await getIt<Sqflite>().insertLocation(event.locationModel);
        // list.add(event.locationModel);
        emit(InsertDetailsSuccessState());
        print('-----------------');
        print(list[0]);
        area.clear();
        street.clear();
        phone.clear();
        details.clear();
        print('-----------success');
      } catch (e) {
        print('-------------------error');
        print(e.toString());
        emit(InsertDetailsFieldState());
      }
    });
    on<GetDetailsEvent>((event, emit) async {
      emit(GetDetailsLoadingState());
      try {
        final locations = await getIt<Sqflite>().getFormDB();
        list = locations.map((e) => LocationModel.fromjson(e)).toList();
        // await getIt<Sqflite>().getFormDB().then((value) {
        //   list = value.map((e) => LocationModel.fromjson(e)).toList();
        // }
        // );

        emit(GetDetailsSuccessState());
      } catch (e) {
        print('-------------------error');
        print(e.toString());
        emit(GetDetailsFieldState());
      }
    });
    //!update
    on<UpdateDetailsEvent>((event, emit) async {
      emit(UpdateDetailsLoadingState());
      try {
        await getIt<Sqflite>().updateDB(event.id);
        emit(UpdateDetailsSuccessState());
      } catch (e) {
        print('-------------------error');
        print(e.toString());
        emit(UpdateDetailsFieldState());
      }
    });
//!delte task
    on<DeleteDetailsEvent>((event, emit) async {
      emit(DeleteDetailsLoadingState());
      try {
        await getIt<Sqflite>().deleteFromDB(event.id);

        emit(DeleteDetailsSuccessState());
        add(GetDetailsEvent());
      } catch (e) {
        print('-------------------error');
        print(e.toString());
        emit(DeleteDetailsFieldState());
      }
    });
  }
}
