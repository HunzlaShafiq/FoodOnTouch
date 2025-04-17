import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fooddelivery/FirebaseDataProviders/CartProvider.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/CartProducts.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/TotalAmountButton.dart';
import 'package:fooddelivery/Utils/LoadingSkletons/CartLoadingSkleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  ValueNotifier<int> total =ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
       title:  Text('Cart',style:GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 28)),),
      ),

    body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 235,right: 10,left: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: gray3,

            ),
            child:Consumer<CartProvider>(
              builder:(context,cartProviderValue,child) {
                if(cartProviderValue.isLoading){

                  return CartLoadingSkeleton();
                }
                else if (cartProviderValue.cartItemsList.isEmpty){
                  return  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            height: 150,
                              width: 150,
                              'assets/emptyCart.png'
                          ).animate().shimmer().then().shake(),
                          Text("No Items in Cart",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        ],
                      )
                  );
                }
                else{
                  return  ListView.builder(
                      itemCount:cartProviderValue.cartItemsList.length,
                      itemBuilder: (context,index){

                        final cartItems = cartProviderValue.cartItemsList[index];

                        final String itemImageUrl =cartItems.itemImageUrl;
                        final String itemPrice =cartItems.itemPrice;
                        final String itemName =cartItems.itemName;
                        final String itemGreetingLine =cartItems.itemGreetingLine;
                        final int itemQuantity =cartItems.itemQuantity;
                        final String id =cartItems.id;
                        final String itemSize =cartItems.itemSize;

                        return CartProducts(
                            itemImageUrl: itemImageUrl,
                            itemName: itemName,
                            itemPrice: itemPrice,
                            itemSize: itemSize,
                            itemGreetingLine: itemGreetingLine,
                            deleteOnTab: (){
                             cartProviderValue.deleteItemFromCart(id);

                            },
                            itemQuantity: itemQuantity,
                            addOnTab: (){
                              // updateQuantity(id,updatedQuantity);
                              cartProviderValue.updateQuantity(id,itemQuantity+1);
                            },
                            minusOnTab: (){
                              if(itemQuantity>1){
                              cartProviderValue.updateQuantity(id,itemQuantity-1);
                              }
                              if(itemQuantity==1){
                                cartProviderValue.deleteItemFromCart(id);
                              }
                              // updateQuantity(id,updatedQuantity);
                            });
                      });
                }

                },
            )

          ),
        ),


        Align(

            alignment: Alignment.bottomCenter,
            child: Consumer<CartProvider>(
                      builder:(context,cartProviderValue,child) {
                        return cartProviderValue.cartItemsList.isEmpty ?
                        Container():
                        TotalAmountButton(
                                    totalAmount: "RS.${cartProviderValue.totalPrice}",
                                      onTab: (){
                                             Navigator.pushNamed(context, RoutesName.checkOut);
                                                  }
              );}
            )
        )

      ],
    )
    );
  }



  void processing (){
    showDialog(
        context: context,
        builder:(context)=>const AlertDialog(
          backgroundColor: Colors.transparent,
          content:Center(child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(color: Colors.black,))),
        ));
  }






}
