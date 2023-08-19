part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}


class CartInitialEvent extends CartEvent{}

class RemoveItemFromCartEvent extends CartEvent{
  final ProductDataModel cartProduct;
  RemoveItemFromCartEvent({
    required this.cartProduct
  });
}
