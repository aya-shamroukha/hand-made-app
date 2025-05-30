import 'package:equatable/equatable.dart';

class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}

class GetAuctionSuccessEvent extends AuctionEvent {}

class GetMakerByAuctionSuccessEvent extends AuctionEvent {
  final dynamic id;

  const GetMakerByAuctionSuccessEvent({required this.id});
}
class GetHandCraftByAuctionSuccessEvent extends AuctionEvent {
  final dynamic id;

  const GetHandCraftByAuctionSuccessEvent({required this.id});
}