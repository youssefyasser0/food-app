import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
    final IconData? icon;
  const CustomIcon({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
      ),
      child: Icon(
        icon, size: 38,
      ),
    );
  }
}
