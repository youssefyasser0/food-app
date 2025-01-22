import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';

class CustomDivide extends StatelessWidget {
  const CustomDivide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: buttonColor,
              height: 22,
              thickness: 10,

            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0 , right: 8.0),
            child: CustomText(title: "OR" , fontSize: 20, fontWeight: FontWeight.bold,),
          ),
          Expanded(
            child: Divider(
              color: buttonColor,
              height: 22,
              thickness: 10,
            ),
          ),
        ],
      ),
    );
  }
}
