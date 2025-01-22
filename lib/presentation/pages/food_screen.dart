import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/data/models/menu_model.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import 'package:food_app/presentation/widgets/food_compo/add_to_cart.dart';
import 'package:food_app/presentation/widgets/food_compo/review_compo.dart';
import 'package:food_app/presentation/widgets/image_section.dart';

class FoodScreen extends StatelessWidget {
  final MenuModel orderFood;
    FoodScreen({super.key, required this.orderFood});

  int quantityOfOrder = 1;
  bool toggleHeart = false;
  bool checkForWish = false;
  bool checkForCart = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    num? totalPrice = orderFood.price;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: iconsBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<FoodAppCubit,FoodAppState>(builder: (context , state){

          if(state is InCreaseNumber || state is DeCreaseNumber){
            if(quantityOfOrder > 1){
              totalPrice = quantityOfOrder * orderFood.price!.round();
              print(totalPrice);
            }
          }

          if(state is AddToWishes){
            toggleHeart = (state).changeHeart;
          }

        return ListView(
        children: [
          //image section
          Container(
              decoration: const BoxDecoration(
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: secondButtonColor,
                      offset: Offset(1.8, 1.8),
                      blurRadius: 3
                  )
                ],
              ),
              height: screenHeight * 0.6,
              child: ImageSection(image: orderFood.image.toString() , width: screenWidth,)),

          // name of food
          Padding(
            padding: const EdgeInsets.only(left: 10.0 , right: 8.0 , top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170,
                  child: CustomText(title: orderFood.name.toString() , fontSize: 28, fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),
                CustomText(title: "\$${totalPrice.toString()}" , fontSize: 28, fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ],
            ),
          ),

          // from which category
          Padding(
            padding: const EdgeInsets.only(left: 10.0 , right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: orderFood.fromCategory.toString(),fontSize: 20,
                  color: buttonColor,fontWeight: FontWeight.bold,),
                InkWell(
                  onTap: (){
                    BlocProvider.of<FoodAppCubit>(context).addToWishList(orderFood);
                    checkForWish = BlocProvider.of<FoodAppCubit>(context).addWishes.contains(orderFood);

                    if(checkForWish == true){
                       ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: CustomText(title: "Added To You Wish List" ,
                             fontSize: 22,fontWeight: FontWeight.bold,)));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: CustomText(title: "Removed from You Wish List" ,
                            fontSize: 22,fontWeight: FontWeight.bold,)));

                    }
                  },
                  child: BlocBuilder<FoodAppCubit , FoodAppState>(builder: (context , state){
                    return const Icon(
                      FontAwesomeIcons.solidHeart  , size: 30,color: Colors.white,
                    );
                  }),
                )
              ],
            ),
          ),

          // food details
          const ReviewCompo(title: "Details"),

          const Divider(
            color: Colors.white,
            height: 5,
            thickness: 2,
            indent: 30,
            endIndent: 30,
          ),

          // the details
          Padding(
            padding: const EdgeInsets.only(left: 15.0 , right: 15.0 , top: 25.0 , bottom: 25.0),
            child: Container(
                constraints: BoxConstraints(
                maxWidth: screenWidth * 0.5,
                maxHeight: screenHeight * 0.4
              ),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: secondButtonColor,
                        offset: Offset(1.8, 1.8),
                        blurRadius: 3
                    )
                  ],
                borderRadius: BorderRadius.circular(10),
                color: iconsBackgroundColor
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 10.0 , right: 10.0 , top: 15 , bottom: 15.0),
                child: CustomText(title: "fqwgp rmgm qpm rmwm rfahqm wwmg ffmqm mwqmm mwqm ffm mw wqffgk " , fontSize: 17,
                                  fontWeight: FontWeight.w600,color: Colors.white,
                ),
              ),
            ),
          ),

          // add to cart and quantity
          AddToCart(title: "$quantityOfOrder",
            inCreaseButton: (){
            quantityOfOrder = BlocProvider.of<FoodAppCubit>(context).inCreaseNumber(number: quantityOfOrder);
          },
            deCreaseButton: (){
            quantityOfOrder = BlocProvider.of<FoodAppCubit>(context).deCreaseNumber(number: quantityOfOrder);
          },
            addToCartButton: (){
              BlocProvider.of<FoodAppCubit>(context).cartShopping(orderFood , totalPrice);
              checkForCart = BlocProvider.of<FoodAppCubit>(context).cartShoppingStorage.contains(orderFood);

              if(checkForCart == true){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: CustomText(title: "Added To Your Cart" ,
                      fontSize: 22,fontWeight: FontWeight.bold,)));
              }
            },
          )
        ],
      );
      })
    );
  }
}
