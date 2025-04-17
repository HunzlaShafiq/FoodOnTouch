import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../FirebaseDataProviders/CartProvider.dart';
import 'CheckOutItems.dart';
import '../Contants/Constants.dart';


class CheckOutItemContainer extends StatefulWidget {
  final VoidCallback editCheckOutItems;
  const CheckOutItemContainer({super.key,
  required this.editCheckOutItems});

  @override
  State<CheckOutItemContainer> createState() => _CheckOutItemContainerState();
}

class _CheckOutItemContainerState extends State<CheckOutItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10,right: 10,left: 10),
          child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: gray3,

              ),
              child:Consumer<CartProvider>(
                builder:(context,cartProviderValue,child) {
                  if(cartProviderValue.isLoading){
                    return const Center(child: CircularProgressIndicator(color: Colors.black,));
                  }
                  else if (cartProviderValue.cartItemsList.isEmpty){
                    return const Center(child: Text("NO Product In Cart"));
                  }
                  else{
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                          itemCount:cartProviderValue.cartItemsList.length,
                          itemBuilder: (context,index){

                            final cartItems = cartProviderValue.cartItemsList[index];

                            final String itemImageUrl =cartItems.itemImageUrl;
                            final String itemName =cartItems.itemName;
                            final int itemQuantity =cartItems.itemQuantity;
                            final String itemSize =cartItems.itemSize;

                            return CheckOutItems(
                                itemImageUrl: itemImageUrl,
                                itemName: itemName,
                                itemQuantity: itemQuantity,
                                itemSize: itemSize
                            );
                          }),
                    );
                  }

                },
              )

          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: widget.editCheckOutItems,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomLeft: Radius.circular(100))
              ),
              child: Center(child: Icon(Icons.edit,size: 20,)),
            ),
          ),
        ),
        Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Consumer<CartProvider>(
                builder:(context,cartProviderValue,child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:"),
                            Text(
                              "Rs.${cartProviderValue.totalPrice.toString()}",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
            )
        )


      ],
    );
  }
}
