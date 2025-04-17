import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final Icon prefixIcon;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  final bool obscureText;

  const MyTextField({super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    required this.validator,
    this.textInputType =TextInputType.text,
    this.obscureText =false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
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
