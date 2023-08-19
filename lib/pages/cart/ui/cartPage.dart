import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/pages/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_project/pages/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_project/pages/home/ui/homeProdcutList.dart';

import 'cartProdcutList.dart';

class CartPage extends StatefulWidget{
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc,CartState>(
      bloc: cartBloc,
        listenWhen: (previous,current) => current is CartActionState,
        buildWhen: (previous,current) => current is !CartActionState,
        listener: (context,state){
          if(state is RemoveFromCartActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Removed from Cart")));
          }
        },
        builder: (context,state){

         switch (state.runtimeType){
           case CartSuccessState :
             final successState = state as CartSuccessState;
             return Scaffold(
               appBar: AppBar(
                 title: const Text(
                   "Your Cart",
                   style: TextStyle(
                       color: Colors.white
                   ),

                 ),
                 centerTitle: true,
                 backgroundColor: Colors.green,
               ),
               body:  successState.cartItems.isNotEmpty ? ListView.builder(
                   itemCount: successState.cartItems.length,
                   itemBuilder: (context,index){
                     return CartProductTileWidget(cartBloc: cartBloc ,productDataModel: successState.cartItems[index]);
                   }
               ) : const Center(child: Text("No Items in the Cart"))
             );
           default : return Scaffold();
         }
       });
    throw UnimplementedError();
  }
}