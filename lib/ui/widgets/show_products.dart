import 'package:ecommerce/data/remote/models/product_model.dart';
import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_bloc.dart';
import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_event.dart';
import 'package:ecommerce/ui/all%20bloc/add_to_favourite_bloc/add_to_favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProducts extends StatelessWidget {
  const ShowProducts({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Image.network(
                  product.image!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 50),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CircleAvatar(radius: 6, backgroundColor: Colors.green),
                        SizedBox(width: 2),
                        CircleAvatar(radius: 6, backgroundColor: Colors.red),
                        SizedBox(width: 2),
                        CircleAvatar(radius: 6, backgroundColor: Colors.blue),
                        SizedBox(width: 4),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: BlocBuilder<FavouriteBloc, FavouriteState>(
              builder: (context, state) {
                bool isFav = false;
                if (state is FavouriteLoadedState) {
                  isFav = state.favouriteProducts.any((p) => p.id == product.id);
                }
                return IconButton(
                  onPressed: () {
                    if (isFav) {
                      context.read<FavouriteBloc>().add(
                            RemoveFromFavouriteEvent(product: product),
                          );
                    } else {
                      context.read<FavouriteBloc>().add(
                            AddToFavouriteEvent(product: product),
                          );
                    }
                  },
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey.shade700,
                    size: 28,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
