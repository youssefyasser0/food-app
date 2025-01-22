import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/data/models/menu_model.dart';
import 'package:food_app/presentation/widgets/custom_button.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import 'food_screen.dart';

class CartShoppingScreen extends StatefulWidget {
  const CartShoppingScreen({super.key});

  @override
  State<CartShoppingScreen> createState() => _CartShoppingScreenState();
}

class _CartShoppingScreenState extends State<CartShoppingScreen> {

  List<MenuModel> cartShopContent = [];
  num? totalPrice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 6,
        ),
      body: BlocBuilder<FoodAppCubit , FoodAppState>(builder: (context , state){

        if(state is CartShop){
            if(state.cartShop.isNotEmpty){
              print("test the cart ${state.cartShop}");
              cartShopContent = (state).cartShop;
              totalPrice = (state).totalPrice;
            }else{
              print("cartShopIsEmpty");
            }
        }



        if(cartShopContent.isNotEmpty) {
          return
            Column(
              children: [
                // total price and checkOut button
                Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(title: "Total: \$$totalPrice",
                          fontSize: 28,
                          fontWeight: FontWeight.bold,),
                        const CustomButton(
                            color: secondButtonColor, height: 50, width: 130,
                            child: CustomText(title: "Check Out",
                              color: Colors.white,))
                      ],
                    ),
                  ),
                ),

                // products in cart
                Expanded(child:
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                      itemCount: cartShopContent.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onLongPress: (){
                            if(cartShopContent.contains(cartShopContent[index])){
                              BlocProvider.of<FoodAppCubit>(context).removeFromCart(totalPrice, cartShopContent[index]);
                            }
                          },
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  FoodScreen(orderFood: cartShopContent[index],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0 , left: 20.0 , right: 20.0),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: iconsBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8.0),
                                  title: CustomText(title: cartShopContent[index].name.toString() , fontSize: 20,
                                    fontWeight: FontWeight.w700,color: backgroundColor,),
                                  leading: Image.asset(cartShopContent[index].image.toString() , height: 220,width: 120,
                                    fit: BoxFit.cover,alignment: Alignment.center,),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )),

              ],
            );
                  }
              else if(cartShopContent.isEmpty){
                return
                    const Center(
                      child: CustomText(title: "Your Cart Is Empty" , fontSize: 28, fontWeight: FontWeight.bold,),
                    );
              }
              else{
                return const CustomText(title: "Sorry , Our Server in Maintain Right Now" , fontSize: 28 ,
                  fontWeight: FontWeight.bold,);
        }

      })

    );
  }
}
