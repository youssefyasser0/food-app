
class MenuModel {

  String? foodId;
  String? fromCategory;
  String? name;
  String? description;
  String? image;
  int? price;

  MenuModel({
    this.foodId,
    this.fromCategory,
    this.name,
    this.description,
    this.image,
    this.price
  });

  MenuModel.fromJson(Map<String , dynamic> json){
    foodId = json["foodId"];
    fromCategory = json["fromCategory"];
    name = json["name"];
    description = json["description"];
    image = json["image"];
    price = json["price"];
  }

  Map<String , dynamic> toJson(){
    return {
      "foodId" : foodId,
      "fromCategory" : fromCategory,
      "name" : name,
      "description" : description,
      "image" : image,
      "price" : price,
    };
  }

}