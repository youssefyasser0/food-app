import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form.dart';
import '../widgets/custom_text.dart';
import '../widgets/login_compo/custom_text_button.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isVisible = true;
  TextEditingController? userNameControl = TextEditingController();
  TextEditingController? emailControl = TextEditingController();
  TextEditingController? passwordControl = TextEditingController();

  void showPassword() {
    setState(() {
      isVisible = !isVisible;
      print(isVisible);
    });
  }

  void registerButton() async{
    
    
    if(userNameControl!.text.isNotEmpty && emailControl!.text.isNotEmpty
        && passwordControl!.text.isNotEmpty
    ){
    await BlocProvider.of<FoodAppCubit>(context).signUp(
        userNameControl!.text,
        emailControl!.text,
        passwordControl!.text);


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
      body: BlocBuilder<FoodAppCubit , FoodAppState>(
        builder: (context , state){

          return Padding(
          padding: const EdgeInsets.only(top: 150.0 , left: 15.0 , right: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title of page
                const CustomText(title: "please register" , fontSize: 48,
                  fontWeight: FontWeight.bold,),

                // user name form field
                 CustomFormField(
                   maxLength: 10,
                   hintText: "user name",
                   obscureText: false,
                   controller: userNameControl,
                ),

                // email form field
                 CustomFormField(
                   hintText: "email",
                   obscureText: false
                   ,controller: emailControl,
                 ),

                // password form field
                CustomFormField(
                  maxLength: 10,
                  hintText: "password", obscureText: isVisible ,
                   controller: passwordControl,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: (){
                        showPassword();
                      },
                      child: Icon(
                        isVisible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye, color: textFormColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),

                // forget password? button
                InkWell(
                    onTap: widget.onTap,
                    child: const CustomTextButton(title: "already have an account?",)),

                // register button
                Center(
                  child: CustomButton( onPressed: registerButton, height: 65, width: 300,color: buttonColor,
                    child: state is UserLoading ? const Center(child: CircularProgressIndicator(),) :
                    const CustomText(title: "register" , color: Colors.white,fontSize: 36,
                      fontWeight: FontWeight.w600,
                    )
                    ,),
                ),

              ],
            ),
          ),
        );
        },

      ),
    );
  }
}
