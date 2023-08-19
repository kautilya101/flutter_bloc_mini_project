import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/pages/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_project/pages/wishlist/ui/wishlistProductList.dart';

class WishListPage extends StatefulWidget{
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    // TODO: implement initState
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc,WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous,current) => current is WishlistActionState,
        buildWhen: (previous,current) => current is !WishlistActionState,
        listener: (context,state){
          if(state is RemoveFromWishlistState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Removed from Wishlist")));
          }
        },
        builder: (context,state){

          switch (state.runtimeType){
            case WishlistSuccessState :
              final successState = state as WishlistSuccessState;
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
                  body:  successState.wishlistItems.isNotEmpty ? ListView.builder(
                      itemCount: successState.wishlistItems.length,
                      itemBuilder: (context,index){
                        return WishlistProductTileWidget(productDataModel: successState.wishlistItems[index], wishlistBloc: wishlistBloc);
                      }
                  ) : const Center(child: Text("No Items in the Wishlist"))
              );
            default : return Scaffold();
          }
        });
  }
}