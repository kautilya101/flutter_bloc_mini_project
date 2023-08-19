part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState{
  List<ProductDataModel> cartItems;
  CartSuccessState({
    required this.cartItems
  });
}

class RemoveFromCartActionState extends CartActionState{}
