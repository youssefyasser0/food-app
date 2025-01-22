import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final int? maxLength;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChange;
  const CustomFormField({super.key, required this.hintText,
    this.controller, required this.obscureText, this.suffixIcon, this.onChange, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0 , bottom: 15.0),
      child: TextFormField(
        onChanged: onChange,
        style: const TextStyle(
          fontSize: 24 , color: textFormColor , fontWeight: FontWeight.bold
        ),
        maxLength: maxLength,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: const EdgeInsets.all(14.0),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          focusedBorder: InputBorder.none ,
          suffixIcon: suffixIcon

        )
      ),
    );
  }
}
