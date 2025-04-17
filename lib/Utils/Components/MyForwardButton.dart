import 'package:flutter/material.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';

class MyForwardButton extends StatelessWidget {
  final Widget content;
  final VoidCallback onTab;
  final bool loading;
  MyForwardButton({super.key,
    required this.content,
    required this.onTab,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          child:Center(child: loading ? const Center(child: CircularProgressIndicator(color: Colors.black,)):
          content
          )

        ),
      ),
    );
  }
}
