import 'package:ecommerce/data/remote/helpers/api_helpers.dart';
import 'package:ecommerce/data/remote/models/order_list_model.dart';
import 'package:ecommerce/domain/constants/app_urls.dart';
import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_event.dart';
import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  ApiHelpers apiHelpers;

  OrdersListBloc({required this.apiHelpers}) : super(OrdersListInitialState()) {
    on<FetchOrdersListEvent>((event, emit) async {
      emit(OrdersListLoadingState());
      try {
        dynamic data = await apiHelpers.postApi(url: AppUrls.URL_GET_ORDERS);
        if (data['status']) {
          List<MainListModel> allOrders = (data['data'] as List)
              .map((item) => MainListModel.fromJson(item))
              .toList();
          emit(OrdersListLoadedState(allOrders: allOrders));
        } else {
          emit(OrdersListFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(OrdersListFailureState(errorMsg: e.toString()));
      }
    });
  }
}
