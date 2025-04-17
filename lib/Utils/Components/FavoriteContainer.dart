import 'package:flutter/material.dart';

import '../Contants/Constants.dart';

class FavoriteContainer extends StatelessWidget {

  final VoidCallback onTab;
  final bool isFavorite;
  const FavoriteContainer({super.key, required this.onTab, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: grayMoreLight,
            borderRadius: BorderRadius.circular(100)
        ),
        child: Center(
            child: isFavorite? Icon(Icons.favorite, color:Colors.redAccent ,size: 28,): Icon(Icons.favorite_border, size: 28,)
        ),
      ),
    );
  }
}
