import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class FavouriteLoadingSkleton extends StatelessWidget {
  const FavouriteLoadingSkleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
      ) ,
      itemCount: 2,
      itemBuilder: (context,index){
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
            child: Container(
              height: 150,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.06),
                  borderRadius: BorderRadius.circular(10)
              ),

            )
        ).animate().shimmer(duration: 80.milliseconds);
      },);
  }
}
