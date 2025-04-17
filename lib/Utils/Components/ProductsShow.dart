import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';

class ProductsShow extends StatelessWidget {
  final String itemImageUrl;
  final String itemName;
  final String itemDescription;
  final String itemPrice;
  final VoidCallback onTabItem;

  const ProductsShow(
      {
        super.key,
      required this.itemImageUrl,
      required this.itemName,
      required this.itemDescription,
      required this.itemPrice,
      required this.onTabItem
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabItem,
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10,),
            MyNetworkCacheImage(imageUrl: itemImageUrl, height: 85, width: 70),
            Text(
              itemName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              itemDescription,
              style: const TextStyle(color: Colors.black38, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text("RS.$itemPrice"),
          ],
        ),
      ),
    );
  }
}
