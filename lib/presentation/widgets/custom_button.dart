import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final double height;
  final double width;
  final Color? color;
  final Widget child;
  const CustomButton({super.key, this.onPressed, required this.height,
    required this.width, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: MaterialButton(
          onPressed: onPressed ,
          child: child,
      ),
    );
  }
}
