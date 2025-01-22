import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  final void Function()? navigateToCartShopping;
  final void Function()? navigateToLogin;
  final void Function()? navigateToWishList;
  final String title;
  const CustomDrawer({
    super.key,
    this.navigateToCartShopping,
    this.navigateToLogin,
    this.navigateToWishList,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0 , right: 25.0 , top: 190.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(title: "hello , $title" , fontSize: 24,fontWeight: FontWeight.bold, ),
                  )),
            ),

              // Cart Shopping
            InkWell(
                onTap: navigateToCartShopping,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Icon(
                            FontAwesomeIcons.cartShopping,
                            size: 22,
                          ),
                        ),
                        CustomText(title: "Cart Shopping" , fontSize: 25,fontWeight: FontWeight.w700,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),

              // Wish List
            InkWell(
              onTap: navigateToWishList,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 14.0),
                          child: Icon(
                            FontAwesomeIcons.heart,
                            size: 22,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: CustomText(title: "Wish List" , fontSize: 25,fontWeight: FontWeight.w700,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),

              // LogOut
            InkWell(
              onTap: navigateToLogin,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: secondButtonColor,
                          offset: Offset(1, 1),
                          blurRadius: 3
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 17.0),
                          child: Icon(
                            FontAwesomeIcons.signOut,
                            size: 22,
                          ),
                        ),
                        CustomText(title: "Log Out" , fontSize: 25,fontWeight: FontWeight.w700,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
