class ProductModel {
    String? name, price, image, id, category_id;

  ProductModel(
      {required this.name, required this.id, required this.price, required this.image, required this.category_id});

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        name:  json['name'],
        id: json['id'],
        price: json['price'],
        image: json['image'],
        category_id: json['category_id']);
  }
}