import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Contants/Constants.dart';

class FavouriteItems extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemGreetingLine;
  final String itemImageUrl;
  final VoidCallback onTabItem;
  final VoidCallback onTabFavouriteItem;

  const FavouriteItems(
      {super.key,
      required this.itemName,
      required this.itemGreetingLine,
      required this.itemImageUrl,
      required this.onTabItem,
        required this.itemPrice, required this.onTabFavouriteItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabFavouriteItem,
      child: Container(
        height: 150,
        width: 180,
        decoration:
            BoxDecoration(color: gray3, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  CachedNetworkImage(
                      height: 70,
                      width: 70,
                      progressIndicatorBuilder:
                          (context, value, downloadedProgress) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.black.withOpacity(.04)),
                          ),
                        );
                      },
                      imageUrl:itemImageUrl
                  ),
                  Text(
                    itemName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    itemGreetingLine,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "RS. $itemPrice",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap:onTabItem ,
                  child: Icon(Icons.favorite_outlined,color: Colors.redAccent, size: 26,))

            )
          ],
        ),
      ),
    );
  }
}
