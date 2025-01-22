import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/data/models/categories_model.dart';
import 'package:food_app/data/models/menu_model.dart';
import 'package:food_app/data/models/user_model.dart';
import 'package:food_app/data/repositories/categories_repo.dart';
import 'package:food_app/data/repositories/map_repo.dart';
import 'package:food_app/data/repositories/menu_repo.dart';
import 'package:food_app/data/repositories/user_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'food_app_state.dart';

class FoodAppCubit extends Cubit<FoodAppState> {
  final UserRepo userRepo;
  UserModel? data;
  MapRepo mapRepo = MapRepo();
  CategoriesRepo categoriesRepo = CategoriesRepo();
  bool? checkLocation;
  Position? userPlace;
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;
  List<Categories> storageCategories = [];
  List<MenuModel> getMenu = [];
  List<MenuModel> cartShoppingStorage = [];
  List<MenuModel> addWishes = [];
  List<num?> totalPriceToCart = [];
  num? resultOfPrice;
  String getUserName = "";
  bool changeHeart = false;
  num? getOneFoodPrice = 0;
  FoodAppCubit(this.userRepo) : super(FoodAppInitial());

    // sign up
  Future<void> signUp(String userName , String email , String password) async{
      UserModel? userModel = UserModel();
    try{
      emit(UserLoading());

      userModel = await userRepo.signup(userName, email, password);
      if(userModel != null){
        data = userModel;
        getUserName = userModel.userName!;
        emit(Authentication(response: data));
      }else{
        emit(UnAuthentication());
      }


    }catch(e){
      print("error in cubit page signUp ${e.toString()}");
      emit(UnAuthentication());
    }

  }

   // get the client userName
  Future<String?> getTheUserName() async{
    UserModel? userModel = UserModel();
    if(userModel != null){
      DocumentSnapshot storage = await FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).get();
      var data = storage.data() as Map<String , dynamic>;
      return data["userName"];
    }
    return null;
  }

  //sign in
  Future<void> signIn(String email , String password) async{
      UserModel? userModel = UserModel();
    try{
      emit(UserLoading());

      userModel = await userRepo.signIn(email, password);
      if(userModel != null){
        data = userModel;
        emit(Authentication(response: data));
      }else{
        emit(UnAuthentication());
      }


    }catch(e){
      print("error in cubit page signin ${e.toString()}");
      emit(UnAuthentication());
    }

  }

  // check user state (if he login or logout)
  Future<void> checkUserState() async{
    UserModel? userModel = UserModel();
    try{
      userModel = await userRepo.checkUserState();
      if(userModel == null){
        emit(UnAuthentication());
      }else{
        data = userModel;
        emit(Authentication(response: data));
      }


    }catch(e){
      print("error in cubit page checkUser ${e.toString()}");
    }
  }

  // reset client password
  Future<void> resetPassword(String myEmail) async{
    await userRepo.resetPassword(myEmail);
  }

  // log out
  Future<void> signOut() async{
    try{

      await userRepo.signOut();
      emit(UnAuthentication());

    }catch(E){
      print("in cubit page signOut${E.toString()}");
      emit(UnAuthentication());
    }
  }

  // send permission to user to get the location
  Future<void> getUserLocation() async{

      emit(UserLocationLoading());
    try{
      Position? userLocation  = await mapRepo.getUserLocation();
        if(userLocation != null){
          userPlace = userLocation;
          print("==================================");
          print("${userPlace}");
          print("==================================");
        }
      emit(GetUserLocation(userPlace: userPlace));
    }catch(E){
      print("in getUserLocation Cubit error is : ${E.toString()} ");
        emit(ErrorToGetUserLocation(message: E.toString()));

    }


  }

  // listen to client change location
  void serviceChange() {

    _serviceStatusSubscription = mapRepo.getServiceStatus().listen( (status) async {
      if(status == ServiceStatus.disabled){
        emit(ErrorToGetUserLocation(message: "please turn on...."));
        userPlace = null;
      }else if(status == ServiceStatus.enabled){
        emit(GetUserLocation(userPlace: userPlace));
      }
    } );

  }

  // get the city and the country
  Future<void> userCountryLocation() async{

    try{
      Position? userLocation = await mapRepo.getUserLocation();
        if(userPlace != null){
          userPlace = userLocation;
          print("Not null");
          List<Placemark> placeMarks = await placemarkFromCoordinates(
            userPlace!.latitude, userPlace!.longitude);
            emit(YourCountry(yourCountryLocation: placeMarks));
        }


    }catch(e){
      print("here ====================> ${e.toString()}");

      throw Exception();
    }

  }

  Future<void> getCategories() async{
    try{
      emit(FoodCategoriesIsLoading());
      storageCategories = await categoriesRepo.getCategories();
      if(storageCategories.isNotEmpty){
         emit(FoodCategoriesIsFetching(allFoodCategories: storageCategories)); 
      }else{
        print("In food app cubit list is empty");
        throw Exception("In cubit ==========================");
      }
    }catch(e){
      emit(FoodCategoriesError(errorMessage: e.toString()));
      print("in Cubit ${e.toString()}");
    }
  }

  // get list of food (MENU)
  getListOfFood() {
    try{
      emit(MenuLoading());
      if(referenceMenu.isNotEmpty){
        getMenu = referenceMenu;
        emit(FetchTheMenu(menu: getMenu));
      }else{
        emit(MenuLoading());
        print("in Cubit List is Empty");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  // inCrease the quantity of food
  int inCreaseNumber({int number = 1}) {
    if(number < 50){
      number++;
    }
    emit(InCreaseNumber(orderNumber: number));
    return number;
  }

  // deCrease the quantity of food
  int deCreaseNumber({int number = 1}) {
    if(number > 1){
      number--;
    }
    emit(DeCreaseNumber(orderNumber: number));
    return number;
  }

  // add order to the cart shop
  cartShopping(MenuModel food , num? total){
    try{
    if(cartShoppingStorage.contains(food)){
      cartShoppingStorage.remove(food);
      totalPriceToCart.remove(total);
    }else{
      cartShoppingStorage.add(food);
      totalPriceToCart.add(total);
      getOneFoodPrice = total;
    }

    if(cartShoppingStorage.isNotEmpty && totalPriceToCart.isNotEmpty){
        resultOfPrice = totalPriceToCart.reduce((x,y) => x! + y!);
        }
      else{
        resultOfPrice = 0;
      }
        emit(CartShop(cartShop: cartShoppingStorage ,resultOfPrice));

    }catch(e){
      throw Exception(e.toString());
    }

    }

  // remove order from cart shop
  void removeFromCart(num? total, MenuModel food) {
    try {
      // Remove the food and its corresponding price
      if (cartShoppingStorage.contains(food)) {
        int index = cartShoppingStorage.indexOf(food);
        cartShoppingStorage.removeAt(index);
        totalPriceToCart.removeAt(index); // Ensure the same index is removed
      }

      // Recalculate the total price
      if (totalPriceToCart.isNotEmpty) {
        resultOfPrice = totalPriceToCart.reduce((x, y) => x! + y!);
      } else {
        resultOfPrice = 0; // Set to 0 if the cart is empty
      }

      // Emit the updated state
      emit(CartShop(cartShop: cartShoppingStorage, resultOfPrice));
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  // add food to wish list
  addToWishList(MenuModel food) {
    if(addWishes.contains(food)){
      addWishes.remove(food);
    }else{
      addWishes.add(food);
    }
      emit(AddToWishes(wishes: addWishes , changeHeart));
  }

}
