import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/presentation/widgets/custom_button.dart';
import 'package:food_app/presentation/widgets/custom_form.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import 'package:food_app/presentation/widgets/login_compo/custom_divide.dart';
import 'package:food_app/presentation/widgets/login_compo/custom_text_button.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isVisible = true;
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  void showPassword() {
    setState(() {
      isVisible = !isVisible;
      print(isVisible);
    });
  }

  void loginButton() async{

      if(emailControl.text.isNotEmpty && passwordControl.text.isNotEmpty){
        BlocProvider.of<FoodAppCubit>(context).signIn(emailControl.text, passwordControl.text);

      }else{
        ScaffoldMessenger.of(context).
        showSnackBar(const SnackBar( backgroundColor: buttonColor,content: CustomText(title: "please fill all the forms" ,
          color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold,)));
      }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
      body: BlocBuilder<FoodAppCubit ,FoodAppState>(

        builder: (context , state){
          return Padding(
            padding:  const EdgeInsets.only(top: 150.0 , left: 15.0 , right: 15.0),
            child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title of page
                const CustomText(title: "please login" , fontSize: 48,
                  fontWeight: FontWeight.bold,),

                // user name form field
                CustomFormField(hintText: "email", obscureText: false ,
                      controller: emailControl,
                ),

                // password form field
                 CustomFormField(hintText: "password", obscureText: isVisible ,
                      controller: passwordControl,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: (){
                        showPassword();
                      },
                      child: Icon(
                        isVisible == false ? Icons.remove_red_eye : Icons.remove_red_eye_outlined , color: textFormColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                // forget password? button
                CustomTextButton(title: "forget your password?",
                  onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                  print("fgwnpoirhgoirphgweiorpg");
                  },),

                // login button
                 Center(
                  child: CustomButton( onPressed: loginButton, height: 65, width: 300,color: buttonColor,
                      child: state is UserLoading ? const Center(child: CircularProgressIndicator(),) :
                      const CustomText(title: "login" , color: Colors.white,fontSize: 36,
                        fontWeight: FontWeight.w600,
                      )
                      ,),
                ),

                // divide
                const CustomDivide() ,

                // don't have an account?
                InkWell(
                  onTap: widget.onTap,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20.0 , bottom: 20.0),
                    child: Center(child: CustomText(title: "don't have an account?" ,
                            color: textFormColor,fontWeight: FontWeight.w600,fontSize: 16,
                    )),
                  ),
                )

              ],
            ),
          ),
            );

        }

      ),

    );
  }
}
