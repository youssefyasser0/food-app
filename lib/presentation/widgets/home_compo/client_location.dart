import 'package:flutter/material.dart';

import '../custom_text.dart';

class ClientLocation extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final void Function()? pressOnArrow;
  const ClientLocation({super.key, required this.title,
        this.onTap, this.pressOnArrow});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText(title: "location" , fontSize: 20,
          color:Color.fromRGBO(59, 59, 59, 0.5), fontWeight: FontWeight.bold,),

        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              const Icon(
                  Icons.location_on
              ) ,
              const SizedBox(width: 10,),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 150
                ),
                child: CustomText(title: title , fontSize: 22,
                  fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: pressOnArrow,
                child: const Icon(
                  Icons.keyboard_arrow_down_sharp , size: 36,
                ),
              ) ,
            ],
          ),
        )

      ],
    );
  }
}


