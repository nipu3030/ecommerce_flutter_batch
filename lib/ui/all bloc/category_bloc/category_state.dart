import '../../../data/remote/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState{}
class CategoryLoadingState extends CategoryState{}
class CategoryLoadedState extends CategoryState{
  List<CategoryModel> allCategory;
  CategoryLoadedState({required this.allCategory});
}
class CategoryFailureState extends CategoryState{
  String errorMsg;
  CategoryFailureState({required this.errorMsg});
}
