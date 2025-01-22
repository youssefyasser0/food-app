part of 'food_app_cubit.dart';

@immutable
sealed class FoodAppState {}

final class FoodAppInitial extends FoodAppState {}

// user loading
class UserLoading extends FoodAppState {}

// authentication
class Authentication extends FoodAppState {
  final UserModel? response;
  Authentication({required this.response});
}

// unAuthentication
class UnAuthentication extends FoodAppState {}

// user location loading
class UserLocationLoading extends FoodAppState {}

// get user location
class GetUserLocation extends FoodAppState {
  final Position? userPlace;
    GetUserLocation({this.userPlace});
}

// error to get user location
class ErrorToGetUserLocation extends FoodAppState {
  final String? message;
  ErrorToGetUserLocation({this.message});
}

// get the country
class YourCountry extends FoodAppState {
  final List<Placemark> yourCountryLocation;
    YourCountry({required this.yourCountryLocation});
}


class FoodCategoriesIsLoading extends FoodAppState{}

class FoodCategoriesError extends FoodAppState{
  final String errorMessage;
    FoodCategoriesError({required this.errorMessage});
}

class FoodCategoriesIsFetching extends FoodAppState{
  final List<Categories> allFoodCategories;
    FoodCategoriesIsFetching({required this.allFoodCategories});
}

// get the food menu
class FetchTheMenu extends FoodAppState {
  List<MenuModel> menu;
  FetchTheMenu({required this.menu});
}

class MenuLoading extends FoodAppState {}

// get the number after +
class InCreaseNumber extends FoodAppState{
  final int orderNumber ;
    InCreaseNumber({required this.orderNumber});
}

// get the number after -
class DeCreaseNumber extends FoodAppState{
  final int orderNumber ;
    DeCreaseNumber({required this.orderNumber});
}

// get the food that's adding in cartShop
class CartShop extends FoodAppState{
  final List<MenuModel> cartShop;
  final num? totalPrice;
  CartShop(this.totalPrice, {required this.cartShop});
}

// get the food that's adding in wish List
class AddToWishes extends FoodAppState{
  final List<MenuModel> wishes;
  final bool changeHeart;
  AddToWishes(this.changeHeart, {required this.wishes});
}