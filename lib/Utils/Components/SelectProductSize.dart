import 'package:flutter/material.dart';


class SelectProductSize extends StatelessWidget {

  final String text;
  final VoidCallback onTab;
  final Color boxColor;

  const SelectProductSize({super.key, required this.text, required this.onTab, required this.boxColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 60,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: boxColor
        ),
        child: Center(child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade500),)),
      ),
    );
  }
}
