import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
    final String image;
    final double? width;
    final double? height;
  const ImageSection({super.key, required this.image, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(image , fit: BoxFit.cover,
          height: height,width: width,)
    );
  }
}
