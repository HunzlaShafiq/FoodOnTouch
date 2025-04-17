import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';

class TotalAmountButton extends StatelessWidget {
  final String totalAmount;
  final VoidCallback onTab;
  final bool loading;
  TotalAmountButton({super.key,
    required this.totalAmount,
    required this.onTab,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,bottom: 90),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTab,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: appColor1
          ),
          child:loading ? const Center(child: CircularProgressIndicator(color: Colors.black,)):
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Text( "Total: $totalAmount",style: const TextStyle(fontSize: 18),),
                          const SizedBox(width: 10,),
                          const Text("CheckOut",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
