import 'package:ecommerce/data/remote/helpers/api_helpers.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_bloc.dart';
import 'package:ecommerce/ui/all%20bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce/ui/all%20bloc/orders_list_bloc/orders_list_bloc.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => UserBloc(apiHelpers: ApiHelpers())),
    BlocProvider(create: (_)=> ProductBloc(apiHelpers: ApiHelpers())),
    BlocProvider(create: (_) => FavouriteBloc()),
    BlocProvider(create: (_)=> CategoryBloc(apiHelpers: ApiHelpers()),),
    BlocProvider(create: (_)=> OrdersListBloc(apiHelpers: ApiHelpers()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoppy',
     routes: AppRoutes.mRoutes(),
      initialRoute: AppRoutes.PAGE_SPLASH,
    );
  }
}

