import 'package:ecommerce/data/remote/helpers/api_helpers.dart';
import 'package:ecommerce/data/remote/models/product_model.dart';
import 'package:ecommerce/domain/constants/app_urls.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_event.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  ApiHelpers apiHelpers;

   ProductBloc({required this.apiHelpers}) : super(ProductInitialState()){

     on<FetchProductEvent>((event,emit) async{

       emit(ProductLoadingState());
       try{
         dynamic data = await apiHelpers.postApi(url: AppUrls.URL_PRODUCTS);
         if(data['status']){
           List<ProductModel> allProduct = (data['data'] as List).map((item) => ProductModel.fromJson(item)).toList();
           emit(ProductLoadedState(allProduct: allProduct));
         }else{
           emit(ProductFailureState(errorMsg: data['message']));
         }
       } catch (e){
         emit(ProductFailureState(errorMsg: e.toString()));
       }
     });
   }
}