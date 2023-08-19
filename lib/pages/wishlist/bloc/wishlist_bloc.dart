import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:flutter_bloc_project/pages/home/models/product_data_,model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<RemoveItemFromWishlist>(removeItemFromWishlist);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter emit
      ){
      emit(WishlistSuccessState(wishlistItems: wishListProducts));
  }

  FutureOr<void> removeItemFromWishlist(
      RemoveItemFromWishlist event, Emitter emit
      ){
    wishListProducts.remove(event.wishlistItem);
    emit(RemoveFromWishlistState());
    emit(WishlistSuccessState(wishlistItems: wishListProducts));
  }
}
