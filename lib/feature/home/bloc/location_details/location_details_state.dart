import 'package:equatable/equatable.dart';

class LocationDetailsState extends Equatable {
  const LocationDetailsState();

  @override
  List<Object> get props => [];
}

final class LocationDetailsInitial extends LocationDetailsState {}

class InsertDetailsSuccessState extends LocationDetailsState {}

class InsertDetailsLoadingState extends LocationDetailsState {}

class InsertDetailsFieldState extends LocationDetailsState {}

class GetDetailsSuccessState extends LocationDetailsState {}

class GetDetailsLoadingState extends LocationDetailsState {}

class GetDetailsFieldState extends LocationDetailsState {}

class UpdateDetailsSuccessState extends LocationDetailsState {}

class UpdateDetailsLoadingState extends LocationDetailsState {}

class UpdateDetailsFieldState extends LocationDetailsState {}

class DeleteDetailsSuccessState extends LocationDetailsState {}

class DeleteDetailsLoadingState extends LocationDetailsState {}

class DeleteDetailsFieldState extends LocationDetailsState {}
