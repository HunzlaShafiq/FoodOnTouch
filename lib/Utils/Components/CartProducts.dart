import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';

import '../Contants/Constants.dart';

class CartProducts extends StatelessWidget {
  final String itemImageUrl;
  final String itemName;
  final String itemPrice;
  final String itemGreetingLine;
  final String itemSize;
  final int itemQuantity;
  final VoidCallback deleteOnTab;
  final VoidCallback addOnTab;
  final VoidCallback minusOnTab;

  const CartProducts(
      {super.key,
      required this.itemImageUrl,
      required this.itemName,
      required this.itemPrice,
      required this.itemGreetingLine,
      required this.deleteOnTab,
      required this.itemQuantity,
      required this.addOnTab,
      required this.minusOnTab,
        required this.itemSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              deleteOnTab();
            },
            icon: Icons.delete_outline,
            label: "Delete",
            backgroundColor: Colors.redAccent,
          )
        ]),
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
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Size: $itemSize",
                        style: const TextStyle(color: grayLight)),
                    Text(itemGreetingLine,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(color: grayLight)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: addOnTab, icon: const Icon(Icons.add)),
                        Text(itemQuantity.toString()),
                        IconButton(
                            onPressed: minusOnTab,
                            icon: const Icon(Icons.remove)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("RS.$itemPrice")
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
