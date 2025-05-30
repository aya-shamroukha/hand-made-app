// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../../core/config/local_storage/sqflite.dart';

class LocationDetailsEvent extends Equatable {
  const LocationDetailsEvent();
  @override
  List<Object> get props => [];
}

class InsertDetailsEvent extends LocationDetailsEvent {
  final LocationModel locationModel;
  @override
  InsertDetailsEvent({required this.locationModel});
  List<Object> get props => [locationModel];
}

class UpdateDetailsEvent extends LocationDetailsEvent {
  int id;
  @override
  UpdateDetailsEvent({
    required this.id,
  });
  List<Object> get props => [id];
}

class GetDetailsEvent extends LocationDetailsEvent {}

class DeleteDetailsEvent extends LocationDetailsEvent {
  int id;
  DeleteDetailsEvent({
    required this.id,
  });
}
