import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/data/grocery.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../models/product_data_,model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
      on<HomeInitialEvent> (homeInitialEvent);
      on<HomeNavigateToCartPageEvent> (homeNavigationToCartPageEvent);
      on<HomeNavigateToWishlistPageEvent> (homeNavigationToWishlistPageEvent);
      on<HomeProductCartClickEvent> (homeProductCartClickEvent);
      on<HomeProductWishlistClickEvent> (homeProductWishlistClickEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit
      ) async {
      emit(HomePageLoadingState());
      await Future.delayed(Duration(seconds: 2));
      emit(HomePageSuccessState(
          products: Grocery.groceryProducts.map((product)
          => ProductDataModel(
              id: product['id'],
              name: product['name'],
              category: product['category'],
              price: product['price'],
              unit: product['unit'],
              image: product['image'])).toList()
      )
      );
  }

  FutureOr<void> homeProductCartClickEvent(
      HomeProductCartClickEvent event, Emitter<HomeState> emit
      ){
      print("Cart product clicked");
      cartProducts.add(event.cartItem);
      emit(HomeProductAddToCartActionState());
  }

  FutureOr<void> homeProductWishlistClickEvent(
      HomeProductWishlistClickEvent event, Emitter<HomeState> emit
      ){
    print("wishlist product clicked");
    wishListProducts.add(event.wishListItem);
    emit(HomeProductAddToWishlistActionState());
  }

  FutureOr<void> homeNavigationToCartPageEvent(
      HomeNavigateToCartPageEvent event, Emitter<HomeState> emit
      ){
      print("cart navigation called");
      emit(HomeNavigationToCartPageActionState());
  }

  FutureOr<void> homeNavigationToWishlistPageEvent(
      HomeNavigateToWishlistPageEvent event, Emitter<HomeState> emit
      ){
    print("wishlist navigation called");
    emit(HomeNavigationToWishlistPageActionState());
  }




}
