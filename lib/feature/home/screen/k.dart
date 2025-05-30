import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_bloc.dart';
import 'package:hand_made_app/feature/auction/bloc/auction_bloc/auction_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/config/local_storage/shared_preferences.dart';
import '../../auction/bloc/auction_bloc/auction_state.dart';
import '../../share/shimmer_body.dart';

class S extends StatelessWidget {
  const S({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuctionBloc()
          ..add(GetMakerByAuctionSuccessEvent(
              id: getIt.get<SharedPreferences>().getInt('auctionId'))),
        child: Scaffold(
          body: Column(
            children: [
              BlocBuilder<AuctionBloc, AuctionState>(
                builder: (context, state) {
                  if (state is GetMakerByAuctionSuccessState) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: state.model.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                'http://199.192.19.220:5400${state.model[index].maker_details.image}',
                                width: 70,
                                height: 100,
                                fit: BoxFit.fill,
                                loadingBuilder: (context, error, stackTrace) {
                                  if (stackTrace == null) {
                                    return Image.network(
                                        width: 70,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        'http://199.192.19.220:5400${state.model[index].maker_details.image}');
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: ShimmerBodyForImage(
                                        width: 70.w,
                                        height: 100.h,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: const ShimmerBodyForImage(
                                      width: 70,
                                      height: 100,
                                    ),
                                  );
                                },
                              );
                            }));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
