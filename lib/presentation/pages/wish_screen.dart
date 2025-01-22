import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/data/models/menu_model.dart';
import '../widgets/custom_text.dart';
import 'food_screen.dart';

class WishScreen extends StatefulWidget {
   const WishScreen({super.key});

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
   List<MenuModel> getTheWishes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 6,
      ),
      body: BlocBuilder<FoodAppCubit ,FoodAppState>(builder: (context , state){

          if(state is AddToWishes){
            getTheWishes = (state).wishes;
          }

          // if list not empty
        if(getTheWishes.isNotEmpty){
          return ListView.builder(
              itemCount: getTheWishes.length,
              itemBuilder: (context , index){
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  FoodScreen(orderFood: getTheWishes[index],)));
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
                          subtitle: CustomText(title: "\$${getTheWishes[index].price}" ),
                          title: CustomText(title: getTheWishes[index].name.toString() , fontSize: 20,
                            fontWeight: FontWeight.w700,color: backgroundColor,),
                          leading: Image.asset(getTheWishes[index].image.toString() , height: 220,width: 120,
                            fit: BoxFit.cover,alignment: Alignment.center,),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }

          // if list is empty
        else if(getTheWishes.isEmpty){
          return const Center(
            child: CustomText(title: "Your Wish List Is Empty" , fontSize: 28, fontWeight: FontWeight.bold,),
          );
        }

        // if there is any error
        else{
          return const Center(
            child: CustomText(title: "Sorry , Our Server in Maintain Right Now" , fontSize: 28, fontWeight: FontWeight.bold,),
          );
        }


      })
    );
  }
}
