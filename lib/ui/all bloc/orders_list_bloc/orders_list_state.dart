import 'package:ecommerce/data/remote/models/order_list_model.dart';

abstract class OrdersListState {}

class OrdersListInitialState extends OrdersListState{}
class OrdersListLoadingState extends OrdersListState{}
class OrdersListLoadedState extends OrdersListState{
  List<MainListModel> allOrders;
  OrdersListLoadedState({required this.allOrders});
}
class OrdersListFailureState extends OrdersListState{
  String errorMsg;
  OrdersListFailureState({required this.errorMsg});
}