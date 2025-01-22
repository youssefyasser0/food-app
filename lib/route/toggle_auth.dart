import 'package:flutter/material.dart';
import 'package:food_app/presentation/auth/login_screen.dart';
import 'package:food_app/presentation/auth/register_screen.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {

  bool toggle = false;

  void toggleBetweenScreens() {
    setState(() {
      toggle = !toggle;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(toggle){
      return RegisterScreen(onTap: (){
        toggleBetweenScreens();
      },);
    }else{
      return LoginScreen(onTap: (){
        toggleBetweenScreens();
      },);
    }
  }
}
