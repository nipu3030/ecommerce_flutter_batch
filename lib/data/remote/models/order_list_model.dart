import 'package:ecommerce/data/remote/models/product_model.dart';

class OrderListModel {
  String? created_at, order_number, status, total_amount;
  int? id;
  List<ProductModel>? product;

  OrderListModel({
    required this.product,
    required this.created_at,
    required this.id,
    required this.order_number,
    required this.status,
    required this.total_amount
  });

  factory OrderListModel.fromMap(Map<String, dynamic> json){
    List<ProductModel> allProducts = [];
    for(Map<String, dynamic> eachMap in json['product']){
      allProducts.add(ProductModel.fromJson(eachMap));
    }

    return OrderListModel(
        product: allProducts,
        created_at: json["created_at"],
        id: json["id"],
        order_number: json["order_number"],
        status: json["status"],
        total_amount: json["total_amount"]);
  }

}

class MainListModel{
  String? message;
  bool? status;
  List<OrderListModel>? orders;

  MainListModel({required this.status,required this.message,required this.orders});

  factory MainListModel.fromJson(Map<String,dynamic> json){

  List<OrderListModel> mOrders = [];

  for(Map<String, dynamic> eachMap in json['orders']){
  mOrders.add(OrderListModel.fromMap(eachMap));
  }
  return MainListModel(
  status: json['status'],
  message: json['message'],
  orders: mOrders);
  }

}
