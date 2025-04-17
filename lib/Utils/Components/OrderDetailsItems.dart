import 'package:flutter/material.dart';
import 'CheckOutItems.dart';
import '../Contants/Constants.dart';


class OrderDetailsItems extends StatelessWidget {

  final List itemList;
  final int totalPrice;

  const OrderDetailsItems({super.key,
    required this.itemList, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0,bottom: 10),
          child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: gray3,

              ),
              child:  Stack(

                children: [
                  Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: ListView.builder(
                            itemCount: itemList.length,
                            itemBuilder: (context,index){

                              final cartItems = itemList[index];

                              final String itemImageUrl =cartItems['itemImageUrl'];
                              final String itemName =cartItems['itemName'];
                              final int itemQuantity =cartItems['itemQuantity'];
                              final String itemSize =cartItems['itemSize'];

                              return CheckOutItems(
                                  itemImageUrl: itemImageUrl,
                                  itemName: itemName,
                                  itemQuantity: itemQuantity,
                                  itemSize: itemSize
                              );
                            }),
                      ),
                  Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                        "Rs.${totalPrice.toString()}",style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ),
                            )
                  )
                ]
              )




          ),
        ),



      ],
    );
  }
}
