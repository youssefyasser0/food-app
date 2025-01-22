import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';


class FoodCategories extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget widget;
  const FoodCategories({super.key, this.width, this.height, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondButtonColor,
      width: width,
      height: height,
      child: widget,
    );
  }
}
