part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}


class HomeInitialEvent extends HomeEvent {}

class HomeNavigateToWishlistPageEvent extends HomeEvent {}

class HomeNavigateToCartPageEvent extends HomeEvent {}

class HomeProductWishlistClickEvent extends HomeEvent {
  final ProductDataModel wishListItem;
  HomeProductWishlistClickEvent({
    required this.wishListItem
  });
}

class HomeProductCartClickEvent extends HomeEvent {
  final ProductDataModel cartItem;
  HomeProductCartClickEvent({
    required this.cartItem
  });
}
