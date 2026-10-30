import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote/helpers/api_helpers.dart';
import '../../../data/remote/models/category_model.dart';
import '../../../domain/constants/app_urls.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc  extends Bloc<CategoryEvent,CategoryState>{
  ApiHelpers apiHelpers;
  CategoryBloc({required this.apiHelpers}) : super(CategoryInitialState()){

    on<FetchCategoryEvent>((event,emit) async {
      emit(CategoryLoadingState());
      try{
        var data = await apiHelpers.getApi(url: AppUrls.URL_CATEGORIES);
        if(data['status']){
          List<CategoryModel> allCategory = (data['data'] as List).map((item) => CategoryModel.fromJson(item)).toList();
          emit(CategoryLoadedState(allCategory: allCategory));
        } else{
          emit(CategoryFailureState(errorMsg: data['message']));
        }
      }catch(e){
        emit(CategoryFailureState(errorMsg: e.toString()));
      }

    });
  }
}