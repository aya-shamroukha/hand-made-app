

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/model/auctions_model/get_auctions_model.dart';
import 'package:hand_made_app/core/domin/model/auctions_model/get_handcraft_byauction_model.dart';
import 'package:hand_made_app/core/domin/service/auctions_service.dart';

import '../../../../core/domin/model/auctions_model/get_maker_byauction_model.dart';
import 'auction_event.dart';
import 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionInitial()) {
     //!getauction
    on<GetAuctionSuccessEvent>((event, emit) async{
        emit(GetAuctionLoadingState());
      try{
        var getAuction = await AuctionImpl().getAuction();
        
      
         
            List<GetAuctionsModel> auction = List.generate(
                getAuction['data'].length,
                (index) =>
                    GetAuctionsModel.fromMap((getAuction['data'][index])));
            emit(GetAuctionSuccessState(model: auction));
          
       
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetAuctionFieldState());
      }
    });
    //!getMaker
     on<GetMakerByAuctionSuccessEvent>((event, emit) async{
        emit(GetMakerByAuctionLoadingState());
      try{
        var getmaker = await AuctionImpl().getMakersByAuction(event.id);
        
      
         
            List<Maker> maker = List.generate(
                getmaker['data'].length,
                (index) =>
                    Maker.fromMap((getmaker['data'][index])));
            emit(GetMakerByAuctionSuccessState(model: maker));
          
       
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetMakerByAuctionFieldState());
      }
    });
     //!gethandcraft
       on<GetHandCraftByAuctionSuccessEvent>((event, emit) async{
        emit(GetHandCraftByAuctionLoadingState());
      try{
        var gethand = await AuctionImpl().getHandcraftByAuction(event.id);
        
      
         
            List<GetHandcraftByAuctionModel> handcraft = List.generate(
                gethand['data'].length,
                (index) =>
                    GetHandcraftByAuctionModel.fromMap((gethand['data'][index])));
            emit(GetHandCraftByAuctionSuccessState(model: handcraft));
          
       
        print('------------------------------------------');
      } catch (e) {
        print(e.toString());
        emit(GetHandCraftByAuctionFieldState());
      }
    });
  }
}
