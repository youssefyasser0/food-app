import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/data/repositories/user_repo.dart';
import 'package:food_app/presentation/pages/home_screen.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import 'package:food_app/route/toggle_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   UserRepo userRepo = UserRepo();
  runApp(
      BlocProvider(
      create: (context) => FoodAppCubit(userRepo)..checkUserState()..serviceChange(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocListener<FoodAppCubit ,FoodAppState>(
        listener: (BuildContext context, FoodAppState state) {

          if(state is ErrorToGetUserLocation){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar( backgroundColor: buttonColor,content: CustomText(title: "please turn on your location" ,
              fontSize: 24, fontWeight: FontWeight.w600,
              ))
            );
          }

        },
        child: BlocBuilder<FoodAppCubit ,FoodAppState>(
          builder: (BuildContext context, FoodAppState state) {

        if(state is Authentication){
          return const HomeScreen();
        }else if(state is UnAuthentication){
          return const ToggleAuth();
        }else if(state is UserLocationLoading){
          return const HomeScreen();
        }else if(state is GetUserLocation){
          return const HomeScreen();
        }else if(state is ErrorToGetUserLocation){
          return const HomeScreen();
        }else if(state is YourCountry){
          return const HomeScreen();
        }else if(state is FoodCategoriesIsFetching || state is FoodCategoriesIsLoading){
          return const HomeScreen();
        }else if(state is FetchTheMenu || state is MenuLoading
            || state is InCreaseNumber ||state is DeCreaseNumber
            || state is CartShop || state is AddToWishes){
          return const HomeScreen();
        }

        else{
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

            },
            ),
      ) );
  }
}


