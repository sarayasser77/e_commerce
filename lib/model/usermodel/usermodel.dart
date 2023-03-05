class UserModel {
  String? name;
  String? phone;
  String? image;
  String? email;
  String? token;
  int? id;
  UserModel.fromJson(Map<String,dynamic> data){
    name = data['name'];
    image = data['image'];
    token = data['token'];
    email = data['email'];
    phone = data['phone'];
    id = data['id'];
  }

}