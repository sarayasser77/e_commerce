class ProductModel{
  int?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String?image;
  String?name;
  String?description;



ProductModel.fromjson({required Map<String,dynamic>data}){
  id=data['id'];
  price=data['price'];
  oldPrice=data["old_price"];
  discount=data['discount'];
  image=data['image'];
  name=data['name'];
  description=data['description'];
}
}