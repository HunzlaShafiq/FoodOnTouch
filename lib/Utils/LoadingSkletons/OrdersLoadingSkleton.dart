import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OrdersLoadingSkleton extends StatelessWidget {
  const OrdersLoadingSkleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 9,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.06),
                    borderRadius: BorderRadius.circular(10)
                ),

              )
          ).animate().shimmer();
        });
  }
}
