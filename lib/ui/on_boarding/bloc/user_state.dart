import 'package:ecommerce/data/remote/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{
  UserModel? userModel;
  UserSuccessState({this.userModel});
}
class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
}