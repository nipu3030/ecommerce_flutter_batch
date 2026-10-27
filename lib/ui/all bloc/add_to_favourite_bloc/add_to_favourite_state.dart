import 'package:ecommerce/data/remote/models/product_model.dart';

abstract class FavouriteState {}

class FavouriteInitialState extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<ProductModel> favouriteProducts;
  FavouriteLoadedState({required this.favouriteProducts});
}

class FavouriteFailureState extends FavouriteState {
  final String errorMsg;
  FavouriteFailureState({required this.errorMsg});
}