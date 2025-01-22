import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';

class ReviewCompo extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const ReviewCompo({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0 , bottom: 25.0 , left: 15.0),
      child: Row(
        children: [
         Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: secondButtonColor,
                  offset: Offset(1.8, 1.8),
                  blurRadius: 3
                )
              ],
              borderRadius: BorderRadius.circular(20),
              color: iconsBackgroundColor
            ),
           child: MaterialButton(onPressed: onPressed ,
           child: CustomText(title: title , fontSize: 20, fontWeight: FontWeight.w600,),
           ),
         ),
        ],
      ),
    );
  }
}
