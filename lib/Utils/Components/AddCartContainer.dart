import 'package:flutter/material.dart';
import '../Contants/Constants.dart';

class AddCartContainer extends StatelessWidget {
  final VoidCallback onTab;
  const AddCartContainer({super.key, required this.onTab});

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
            color: appColor2,
            borderRadius: BorderRadius.circular(100)
        ),
        child: const Center(
            child: Icon(Icons.shopping_cart_outlined,size: 28,
            )
        ),
      ),
    );
  }
}
