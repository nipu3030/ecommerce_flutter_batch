import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_bloc.dart';
import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_state.dart';
import 'package:ecommerce/ui/widgets/show_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavFavouritePage extends StatelessWidget {
  const NavFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoadedState) {
            if (state.favouriteProducts.isEmpty) {
              return const Center(
                child: Text('No Favourite Products Added Yet!'),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.favouriteProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                var product = state.favouriteProducts[index];
                return ShowProducts(product: product);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
