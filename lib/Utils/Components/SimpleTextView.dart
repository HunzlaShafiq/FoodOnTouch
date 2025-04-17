import 'package:flutter/material.dart';


class SimpleTextView extends StatelessWidget {

  final TextEditingController controller;
  final Icon prefixIcon;


  const SimpleTextView({super.key,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon:  prefixIcon,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)
              )
          )
      ),
    );
  }
}
