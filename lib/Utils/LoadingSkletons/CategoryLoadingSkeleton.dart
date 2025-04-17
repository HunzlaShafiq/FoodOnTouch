import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CategoryLoadingSkeleton extends StatelessWidget {
  const CategoryLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Container(
                height: 150,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.06),
                    borderRadius: BorderRadius.circular(10)
                ),

              )
          ).animate().shimmer();
        });
  }
}
