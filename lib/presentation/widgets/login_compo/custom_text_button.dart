import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomTextButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          InkWell(
            onTap: onPressed,
            child: CustomText(title: title , color: textFormColor,fontSize: 16,
              fontWeight: FontWeight.w600,),
          )
        ],
      ),
    );
  }
}
