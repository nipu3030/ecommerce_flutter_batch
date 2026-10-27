import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_bloc.dart';
import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_event.dart';
import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavShoppingCart extends StatefulWidget {
  const NavShoppingCart({super.key});

  @override
  State<NavShoppingCart> createState() => _NavShoppingCartState();
}

class _NavShoppingCartState extends State<NavShoppingCart> {

  @override
  void initState() {
    context.read<OrdersListBloc>().add(FetchOrdersListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersListBloc,OrdersListState>(
        builder: (_,state){
          if(state is OrdersListLoadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is OrdersListLoadedState){
            return state.allOrders.isEmpty ? Center(child: Text("Orders Not Found!"),) : GridView.builder(
                itemCount:  state.allOrders.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_,index){
                  var data = state.allOrders[index].orders![index].product![index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(data.image.toString())
                      ],
                    ),
                  );
                });
          }
          if(state is OrdersListFailureState){
            return Center(child: Text(state.errorMsg),);
          }
          return Container();
        },
      ),
    );
  }
}
