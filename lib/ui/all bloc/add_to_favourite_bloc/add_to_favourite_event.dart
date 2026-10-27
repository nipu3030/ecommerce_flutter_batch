import 'package:ecommerce/data/remote/models/product_model.dart';

abstract class FavouriteEvent {}

class AddToFavouriteEvent extends FavouriteEvent {
  final ProductModel product;
  AddToFavouriteEvent({required this.product});
}

class RemoveFromFavouriteEvent extends FavouriteEvent {
  final ProductModel product;
  RemoveFromFavouriteEvent({required this.product});
}

class FetchFavouriteEvent extends FavouriteEvent {}