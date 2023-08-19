import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../../home/models/product_data_,model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent> (cartInitialEvent);
    on<RemoveItemFromCartEvent> (removeItemFromCartEvent);
  }


  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter emit
      ){
    emit(CartSuccessState(cartItems: cartProducts));
  }

  FutureOr<void> removeItemFromCartEvent(
      RemoveItemFromCartEvent event, Emitter emit
      ){
    cartProducts.remove(event.cartProduct);
    emit(CartSuccessState(cartItems: cartProducts));
  }


}
