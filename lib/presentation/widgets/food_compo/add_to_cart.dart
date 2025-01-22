import 'package:flutter/material.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';

class AddToCart extends StatelessWidget {
    final void Function()? deCreaseButton;
    final void Function()? inCreaseButton;
    final void Function()? addToCartButton;
    final String title;
  const AddToCart({super.key, required this.title, this.deCreaseButton,
    this.inCreaseButton, this.addToCartButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0 , left: 9.0 , right: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            // increase and decrease the quantity
          Container(
            width: 177,
            height: 65,
            constraints: const BoxConstraints(
              maxWidth: 177,
              maxHeight: 70
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  // decrease
                  Container(
                    width: 55,
                    height: 55,
                      decoration: BoxDecoration(
                        color: secondButtonColor,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: MaterialButton(onPressed: deCreaseButton ,
                              child: const CustomText(title: "-" , fontSize: 25,color: Colors.white,
                                    fontWeight: FontWeight.bold,
                              ),
                      ),
                  ),
                  const SizedBox(width: 20,),
                  SizedBox(width: 30,child: CustomText(title: title , fontSize: 22,fontWeight: FontWeight.w500,)),
                  const SizedBox(width: 5,),
                  Container(
                    width: 55,
                    height: 55,
                      decoration: BoxDecoration(
                        color: secondButtonColor,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: MaterialButton(onPressed: inCreaseButton ,
                              child: const CustomText(textAlign: TextAlign.center,title: "+" , fontSize: 25,color: Colors.white,
                                    fontWeight: FontWeight.bold,
                              ),
                      ),
                  ),
                ],
              ),
            ),
          ),

            // add to cart button
          Container(
            width: 170,
            height: 65,
            decoration: BoxDecoration(
                color: secondButtonColor,
                borderRadius: BorderRadius.circular(50)
            ),
              child: MaterialButton(onPressed: addToCartButton ,
                    child: const CustomText(title: "Add To Cart" , fontSize: 20,
                      fontWeight: FontWeight.bold,color: Colors.white,),
              ),
          )
        ],
      ),
    );
  }
}
