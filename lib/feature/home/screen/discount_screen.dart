import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/discount_bloc/discount_bloc.dart';
import 'package:hand_made_app/feature/home/bloc/discount_bloc/discount_event.dart';


import '../bloc/discount_bloc/discount_state.dart';


class GetAllDiscountScreen extends StatelessWidget {
  const GetAllDiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscountBloc()..add(GetAllDiscountEvent()),
      child: Scaffold(
        body: BlocBuilder<DiscountBloc, DiscountState>(
          builder: (context, state) {
            if (state is GetAllDiscountSuccessState) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.discount.length,
                          itemBuilder: (context, index) {
                            return Text(state.discount[index].name);
                          }))
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
