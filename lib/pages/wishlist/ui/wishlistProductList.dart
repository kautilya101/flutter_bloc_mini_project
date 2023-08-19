import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/pages/home/models/product_data_,model.dart';
import 'package:flutter_bloc_project/pages/wishlist/bloc/wishlist_bloc.dart';

import '../../../data/wishlist_items.dart';

class WishlistProductTileWidget extends StatefulWidget{
  final WishlistBloc wishlistBloc;
  final ProductDataModel productDataModel;
  const WishlistProductTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  State<WishlistProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<WishlistProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    bool isAddedToWishlist = wishListProducts.contains(widget.productDataModel);
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal:20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white70, Colors.white30]
                    ),
                    image: DecorationImage(fit: BoxFit.cover  ,image: NetworkImage(widget.productDataModel.image))
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.topRight,
                child: InkWell(
                  child: CircleAvatar(
                    child: IconButton(
                      icon: isAddedToWishlist ?  const Icon(
                          Icons.favorite_rounded,
                        color: Colors.redAccent,
                      ) : const Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: (){
                        if(wishListProducts.contains(widget.productDataModel)){
                          widget.wishlistBloc.add(RemoveItemFromWishlist(wishlistItem: widget.productDataModel));
                        }
                        setState(() {
                          isAddedToWishlist = wishListProducts.contains(widget.productDataModel);
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white,Colors.redAccent.shade100],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productDataModel.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Nunito'
                          )
                      ),
                      Text(widget.productDataModel.category,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito'
                          )
                      )
                    ],
                  ),
                  // InkWell(
                  //     child: IconButton(
                  //         icon: const Icon(
                  //             Icons.favorite,
                  //           color: Colors.redAccent,
                  //         ),
                  //         onPressed: (){
                  //           widget.wishlistBloc.add(RemoveItemFromWishlist(wishlistItem: widget.productDataModel));
                  //         }
                  //     )
                  // )
                ],
              ),
            ),
          )

        ],
      ),
    );
    throw UnimplementedError();
  }
}