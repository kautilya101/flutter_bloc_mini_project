part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class RemoveItemFromWishlist extends WishlistEvent {
  final ProductDataModel wishlistItem;
  RemoveItemFromWishlist({
    required this.wishlistItem
});
}
