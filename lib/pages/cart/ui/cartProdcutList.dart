

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/data/cart_items.dart';
import 'package:flutter_bloc_project/data/wishlist_items.dart';
import 'package:flutter_bloc_project/pages/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/pages/home/models/product_data_,model.dart';

import '../bloc/cart_bloc.dart';

class CartProductTileWidget extends StatefulWidget{
  final CartBloc cartBloc;
  final ProductDataModel productDataModel;
  const CartProductTileWidget({super.key, required this.productDataModel, required this.cartBloc});

  @override
  State<CartProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<CartProductTileWidget> {
  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black87,
                      ),
                      onPressed: (){
                        // widget.cartBloc.add();
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
                   InkWell(
                      child: IconButton(
                          icon: const Icon(
                              Icons.remove_shopping_cart
                          ),
                          onPressed: (){
                            widget.cartBloc.add(RemoveItemFromCartEvent(cartProduct: widget.productDataModel));
                          }
                          )
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