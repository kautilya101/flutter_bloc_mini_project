import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:flutter_bloc_project/pages/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/pages/home/models/product_data_,model.dart';

class ProductTileWidget extends StatefulWidget{
  final HomeBloc homeBloc;
  final ProductDataModel productDataModel;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    bool isAddedToCart = cartProducts.contains(widget.productDataModel);
    bool isAddedToWishList = wishListProducts.contains(widget.productDataModel);
    print(isAddedToCart);
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
                      icon: !isAddedToWishList ? const Icon(Icons.favorite_border_outlined, color: Colors.black87) : const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                      onPressed: (){
                         if(!wishListProducts.contains(widget.productDataModel)) {
                           widget.homeBloc.add(HomeProductWishlistClickEvent(
                               wishListItem: widget.productDataModel)
                           );
                         }
                         setState(() {
                           isAddedToWishList = wishListProducts.contains(widget.productDataModel);
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
                   AnimatedSwitcher(
                     duration: Duration(microseconds: 1000),
                     child: IconButton(
                         icon: !isAddedToCart ? const Icon(
                             Icons.add_shopping_cart) :  const Icon(Icons.check) ,
                         onPressed: (){
                           if(!cartProducts.contains(widget.productDataModel)) {
                             widget.homeBloc.add(HomeProductCartClickEvent(
                                 cartItem: widget.productDataModel));
                           }
                           setState(() {
                             print(isAddedToCart);
                             isAddedToCart = cartProducts.contains(widget.productDataModel);
                           });
                         }
                       ),
                   )
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