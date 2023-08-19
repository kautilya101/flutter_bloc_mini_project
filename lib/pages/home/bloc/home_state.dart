part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageSuccessState extends HomeState {
  List<ProductDataModel> products;
  HomePageSuccessState({required this.products});
}

class HomePageErrorState extends HomeState {}

class HomeNavigationToWishlistPageActionState extends HomeActionState{}

class HomeNavigationToCartPageActionState extends HomeActionState{}

class HomeProductAddToCartActionState extends HomeActionState{}

class HomeProductAddToWishlistActionState extends HomeActionState{}


