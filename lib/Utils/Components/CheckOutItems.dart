import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';

import '../Contants/Constants.dart';

class CheckOutItems extends StatelessWidget {
  final String itemImageUrl;
  final String itemName;
  final String itemSize;
  final int itemQuantity;


  const CheckOutItems(
      {super.key,
        required this.itemImageUrl,
        required this.itemName,
        required this.itemQuantity,
        required this.itemSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 125,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              MyNetworkCacheImage(imageUrl: itemImageUrl, height: 100, width: 100),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    itemName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Row(

                    children: [
                      Text(
                          "Size:          ",
                          style: const TextStyle(color: grayLight)),
                      Text(
                          itemSize=='S' ? "Small": itemSize=='M' ? "Medium": "Large",
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(
                          "Quantity:   ",
                          style: const TextStyle(color: grayLight)),
                      Text(
                          itemQuantity.toString(),
                          style: const TextStyle(color: Colors.black)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
