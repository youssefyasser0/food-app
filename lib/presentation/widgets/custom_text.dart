import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const CustomText({super.key, required this.title,
    this.fontSize, this.fontWeight, this.color, this.overflow, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ,overflow: overflow, textAlign: textAlign,style: GoogleFonts.poppins(
      fontSize: fontSize , fontWeight: fontWeight ,
      color: color ,
    ),
    );
  }
}
