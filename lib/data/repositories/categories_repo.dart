import 'package:dio/dio.dart';
import 'package:food_app/data/models/categories_model.dart';
import 'package:food_app/data/models/food_categories.dart';

class CategoriesRepo {
  Dio dio = Dio();
  List<Categories> categoriesStorage = [];
Future<List<Categories>> getCategories() async{

  try{
      Response response = await dio.get("https://www.themealdb.com/api/json/v1/1/categories.php");
      if(response.statusCode == 200){
      FoodCategories foodCategories = FoodCategories.fromJson(response.data);
      categoriesStorage = foodCategories.categories!;
        print(categoriesStorage);
      return categoriesStorage;
  }else{
    throw Exception("Error when you try to get the data form API ${response.statusCode}");
  }
  }catch(e){
    print("In Categories repo");
    return [];
  }


}



}