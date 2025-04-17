import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fooddelivery/Provider/FavouriteProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/FavouriteItems.dart';
import 'package:fooddelivery/Utils/LoadingSkletons/FavouriteLoadingSkleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Text('Favourites',style:GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 28)),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
          child: Consumer<FavouriteProvider>(builder: (context,FavouriteProviderValues,child){

           if (FavouriteProviderValues.isLoading){
              return FavouriteLoadingSkleton();
            }

           else if(FavouriteProviderValues.favouriteItemsList.isEmpty){
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        height: 160,
                        width: 160,
                        'assets/emptyFavourite.png'
                    ).animate().shimmer().then().shake(),
                    Text("No Items in Favourite",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    SizedBox(height: 150,)
                  ],
                )
            );
            }
            else{

              return GridView.builder(
                  itemCount: FavouriteProviderValues.favouriteItemsList.length,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                     crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context,index){


                    final favouriteItemsInfo = FavouriteProviderValues.favouriteItemsList[index];

                    final itemName =favouriteItemsInfo.itemName;
                    final itemPrice =favouriteItemsInfo.itemPrice;
                    final itemGreetingLine =favouriteItemsInfo.itemGreetingLine;
                    final itemImageUrl =favouriteItemsInfo.itemImageUrl;
                    final id = favouriteItemsInfo.id;

                    return FavouriteItems(
                        itemName: itemName,
                        onTabFavouriteItem: (){
                          Navigator.pushNamed(
                              context, RoutesName.productPreview,
                            arguments: {
                              'itemId':id,
                              'itemName':itemName,
                              'itemDescription':itemGreetingLine,
                              'itemPrice': itemPrice,
                              'itemImageUrl': itemImageUrl
                            }
                          );
                        },
                        itemGreetingLine: itemGreetingLine,
                        itemImageUrl: itemImageUrl,
                        onTabItem: (){
                          FavouriteProviderValues.deleteFavouriteItem(id);
                        },
                        itemPrice: itemPrice
                    );
                  }
              );
            }

          }),
        )
    );
  }
}
