import 'package:ecommerce/data/remote/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_to_favourite_event.dart';
import 'add_to_favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  final List<ProductModel> _favouriteProducts = [];

  FavouriteBloc() : super(FavouriteLoadedState(favouriteProducts: const [])) {

    on<AddToFavouriteEvent>((event,emit){
      if(!_favouriteProducts.contains(event.product)){
        _favouriteProducts.add(event.product);
        emit(FavouriteLoadedState(favouriteProducts: _favouriteProducts));
      }else{
        emit(FavouriteFailureState(errorMsg: "Product already added to favourites"));
      }
    });

    on<RemoveFromFavouriteEvent>((event,emit){
      if(_favouriteProducts.contains(event.product)){
        _favouriteProducts.remove(event.product);
        emit(FavouriteLoadedState(favouriteProducts: _favouriteProducts));
      } else {
        emit(FavouriteFailureState(errorMsg: "Product not found in favourites"));
      }
    });

    on<FetchFavouriteEvent>((event,emit){
      emit(FavouriteLoadedState(favouriteProducts: _favouriteProducts));
    });

    }
  }
