import 'package:ecommerce/data/remote/models/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState{}
class ProductLoadingState extends ProductState{}
class ProductLoadedState extends ProductState{
  List<ProductModel> allProduct;
  ProductLoadedState({required this.allProduct});
}
class ProductFailureState extends ProductState{
  String errorMsg;
  ProductFailureState({required this.errorMsg});
}