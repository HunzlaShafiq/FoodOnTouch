import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ProductsLoadingSkleton extends StatelessWidget {
  const ProductsLoadingSkleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: .9,
            crossAxisSpacing: 10
        ) ,
        itemCount: 6,
        itemBuilder: (context,index){
          return Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.06),
                borderRadius: BorderRadius.circular(10)
            ),

          ).animate().shimmer();
        },),
    );
  }
}
