import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/CategoriesProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/FetchProductsProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/OrdersProvider.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/Provider/BottomNavProvider.dart';
import 'package:fooddelivery/Provider/FavouriteProvider.dart';
import 'package:provider/provider.dart';

class  LoginAndLogoutServices{


  void userLogOut(BuildContext context)async{

    await  Provider.of<CategoriesProvider>(context,listen: false).clearCategoriesOnUserLogOut();

    await Provider.of<FetchProductsProvider>(context,listen: false).clearProductsDataOnUserLogOut();

    await Provider.of<CartProvider>(context,listen: false).clearCartItemsOnUserLogOut();

    Provider.of<FavouriteProvider>(context,listen: false).clearFavouriteItemsOnUserLogOut();

    await Provider.of<ProfileProvider>(context,listen: false).clearProfileDataOnUserLogOut();

    Provider.of<OrdersProvider>(context,listen: false).clearOrderDataOnLogOut();
    
    Provider.of<BottomNavProvider>(context,listen: false).changeIndex(0);

  }

  void userLogIn(BuildContext context) async{

   Provider.of<CategoriesProvider>(context,listen: false).refreshCategoriesOnUserLogIn();

   Provider.of<FetchProductsProvider>(context,listen: false).refreshProductsDataOnUserLogIn();

   Provider.of<CartProvider>(context,listen: false).refreshCategoriesOnUserLogIn();

   Provider.of<FavouriteProvider>(context,listen: false).refreshFavouriteItemsOnUserLogIn();

   Provider.of<ProfileProvider>(context,listen: false).refreshProfileDataOnUserLogIn();

   Provider.of<OrdersProvider>(context,listen: false).refreshOrderDataOnLogIn();


  }


}