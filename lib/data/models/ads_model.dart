
class OffersModel {

  String? content;
  String? image;

  OffersModel({ this.content,  this.image});

  OffersModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['image'] = this.image;
    return data;
  }

}
