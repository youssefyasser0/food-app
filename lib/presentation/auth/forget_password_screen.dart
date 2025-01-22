import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/auth/login_screen.dart';
import 'package:food_app/presentation/widgets/custom_button.dart';
import 'package:food_app/presentation/widgets/custom_form.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import '../../business_logic/food_app_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
   const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
   TextEditingController? resetEmailControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FoodAppCubit ,FoodAppState>(builder: (context , state){

         return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // send message to email text
            const CustomText(title: "Please Enter Your Email To Reset You Password"  ,
                fontSize: 24, fontWeight: FontWeight.bold,
            ),

            // email form
            CustomFormField(hintText: "Enter Your Email", obscureText: false ,controller: resetEmailControl,),

            // send the message button
            CustomButton(color: buttonColor,height: 65, width: 300,

                onPressed: () {
                      if(resetEmailControl!.text.isNotEmpty) {
                        BlocProvider.of<FoodAppCubit>(context).resetPassword(resetEmailControl!.text);
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar( backgroundColor: buttonColor,
                            content: CustomText(title: "Please Check Your Email " ,
                          color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold,)));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                      }else{
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar( backgroundColor: buttonColor,
                            content: CustomText(title: "Please Type Your Email " ,
                              color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold,)));
                      }
                },

                child: const CustomText(title: "SEND" , fontSize: 24, fontWeight: FontWeight.bold,
                      color: Colors.white,
                ))
          ],
        ),
      );


      })

    );
  }
}
