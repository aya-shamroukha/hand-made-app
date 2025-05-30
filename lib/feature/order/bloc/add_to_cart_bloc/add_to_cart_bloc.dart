import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_made_app/core/domin/model/categories_model/get_hand_craftdetail_model.dart';

import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  //List<GetHandCraftdetailModel> get cartItems => List.unmodifiable(_cartItems);
  List<GetHandCraftdetailModel> cartItems = [];
  AddToCartBloc() : super(AddToCartInitial()) {
    on<AddToCartSuccessEvent>((event, emit) {
      final existingItemIndex =
          cartItems.indexWhere((item) => item.id == event.handcraft.id);
      {
        // If the item exists, increment its quantity
        if (existingItemIndex != -1) {
          cartItems[existingItemIndex].quantity++;
        } else {
          event.handcraft.quantity = 1;

          // If the item doesn't exist, add it to the cart with quantity 1
          cartItems.add(event.handcraft);
        }

        print('Adding item to cart: ${event.handcraft.handcraft_name}');
        //cartItems.add(event.handcraft);

        print(cartItems.length);
        print('-----------------');
        emit(AddToCartSuccessState());
        //  emit(GetCartState(cartItems: cart));
      }
    });
    on<GetCartEvent>(
      (event, emit) {
        // final cart = List<GetHandCraftdetailModel>.from(cartItems);
        //  ..add(event.handcraft);

        emit(GetCartState(cartItems: List.from(cartItems)));
        print('Getting cart items: ${cartItems.length}');
      },
    );
    on<RemoveFromcartEvent>(
      (event, emit) {
        final index = cartItems.indexWhere((item) => item.id == event.id);
        if (index != -1) {
          if (cartItems[index].quantity > 1) {
            // Decrement quantity if greater than 1
            cartItems[index].quantity--;
          } else {
            // Remove item if quantity is 1
            cartItems.removeAt(index);
          }
          emit(RemoveFromCartSuccessState(cartItems: List.from(cartItems)));
        }
        emit(GetCartState(cartItems: List.from(cartItems)));

        // if (cartItems.isEmpty) {
        //   if (cartItems.any((item) => item.id == event.id)) {
        //     cartItems.removeWhere((item) => item.id == event.id);
        //   } else {
        //     print('Item with ID ${event.id} does not exist in the cart.');
        //   }
        //   print('Cart is empty. Nothing to remove.');
        //   emit(GetCartState(cartItems: List.from(cartItems)));
        //   return;
        // }

        // print('Removing item from cart: ${event.id}');
        // final removed = cartItems.removeWhere((item) => item.id == event.id);

        // // Ensure the removal occurred

        // emit(RemoveFromCartSuccessState(cartItems: List.from(cartItems)));
        // emit(GetCartState(cartItems: List.from(cartItems)));
      },
    );
    on<DeleteFromcartEvent>(
      (event, emit) {
        // Remove the item completely from the cart
        cartItems.removeWhere((item) => item.id == event.id);

        // Emit the updated state
        emit(DeleteFromcartSuccessState(cartItems: List.from(cartItems)));
        emit(GetCartState(cartItems: List.from(cartItems)));
      },
    );
  }
}
