import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';

class CategoriesList extends StatelessWidget {

  final String categoryName;
  final String categoryUrl;
  final VoidCallback onTab;
  final String selectedCategory ;

  const CategoriesList({super.key,
    required this.categoryName,
    required this.categoryUrl,
    required this.onTab, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        focusColor: Colors.transparent,
        onTap: onTab,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color:selectedCategory==categoryName? Colors.amberAccent.shade200: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              MyNetworkCacheImage(imageUrl: categoryUrl, height: 60, width: 60),
              Text(categoryName,overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,)

            ],
          ),
        ),
      ),
    );
  }
}
