class UserModel {
  String? userId;
  String? userName;
  String? email;

  UserModel({this.userId , this.userName , this.email});

    // convert model to dart Object to make flutter understand
  UserModel.fromJson(Map<String ,dynamic> json){
    userId = json["userId"];
    userName = json["userName"];
    email = json["email"];
  }

    // convert model to map to make data base understand
  Map<String , dynamic> toJson() {
    return{
      "userId" : userId ,
      "userName" : userName ,
      "email" : email
    };
  }


}