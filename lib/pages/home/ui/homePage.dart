import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/pages/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/pages/home/ui/homeProdcutList.dart';
import 'package:flutter_bloc_project/pages/wishlist/ui/wishListPage.dart';

import '../../cart/ui/cartPage.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
    listenWhen: (previous, current) => current is HomeActionState,
    buildWhen: (previous, current) => current is !HomeActionState,
    listener: (context, state) {
      if(state is HomeNavigationToCartPageActionState){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
      }
      else if(state is HomeNavigationToWishlistPageActionState){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WishListPage() ));
      }
      else if(state is HomeProductAddToCartActionState){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Added to Cart")));
      }
      else if(state is HomeProductAddToWishlistActionState){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Added to Wishlist")));
      }
    },
    builder: (context, state) {
      switch(state.runtimeType){
        case HomePageLoadingState :
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        case HomePageSuccessState :
          final successState = state as HomePageSuccessState;
          return Scaffold(
            appBar: AppBar(
              title: const Text("GrocBuy",
              style: TextStyle(
                color: Colors.white
              )),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: [
                IconButton(icon: const Icon(Icons.favorite_border,color: Colors.white),onPressed: (){
                  homeBloc.add(HomeNavigateToWishlistPageEvent());
                }),
                IconButton(icon: const Icon(Icons.card_travel_outlined,color: Colors.white),onPressed: (){
                  homeBloc.add(HomeNavigateToCartPageEvent());
                }),
              ],
            ),
            body: ListView.builder(
              itemCount: successState.products.length,
                itemBuilder: (context,index){
                  return ProductTileWidget(homeBloc:homeBloc ,productDataModel: successState.products[index]);
                }
            )
          );

        case HomePageErrorState :
          return const Scaffold(
            body: Center(
              child: Text("Something Went Wrong!"),
            ),
          );
        default : return const Scaffold(body: Center(child: Text("No Results")));
      }
  },
);

    throw UnimplementedError();
  }
}
