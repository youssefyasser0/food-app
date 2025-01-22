import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../custom_button.dart';
import '../custom_text.dart';

class CustomAdsView extends StatelessWidget {
    final String adImage;
    final String adContent;
  const CustomAdsView({super.key, required this.adImage, required this.adContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(adImage),fit: BoxFit.cover,
          opacity: 0.4 ,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0 , right: 8.0 , top: 20.0 , bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: CustomText(title: adContent , fontWeight: FontWeight.bold,
                  fontSize: 28,color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
