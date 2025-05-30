 import 'package:equatable/equatable.dart';
import 'package:hand_made_app/core/domin/model/auctions_model/get_auctions_model.dart';
import 'package:hand_made_app/core/domin/model/auctions_model/get_handcraft_byauction_model.dart';
import 'package:hand_made_app/core/domin/model/auctions_model/get_maker_byauction_model.dart';

class AuctionState extends Equatable {
  const AuctionState();
  
  @override
  List<Object> get props => [];
}

final class AuctionInitial extends AuctionState {}
//!getauction
class GetAuctionSuccessState extends AuctionState {
  final List <GetAuctionsModel> model;

 const GetAuctionSuccessState({required this.model});
}

class GetAuctionLoadingState extends AuctionState {}

class GetAuctionFieldState extends AuctionState {}
//!getMaker
 class GetMakerByAuctionSuccessState extends AuctionState {
  final List <Maker> model;

 const GetMakerByAuctionSuccessState({required this.model});
}

class GetMakerByAuctionLoadingState extends AuctionState {}

class GetMakerByAuctionFieldState extends AuctionState {}
 
//!getHandcraft
 class GetHandCraftByAuctionSuccessState extends AuctionState {
  final List <GetHandcraftByAuctionModel> model;

 const GetHandCraftByAuctionSuccessState({required this.model});
}

class GetHandCraftByAuctionLoadingState extends AuctionState {}

class GetHandCraftByAuctionFieldState extends AuctionState {}