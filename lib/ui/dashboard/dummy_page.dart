import 'package:flutter/material.dart';

class CategoryModel {
  String title,imageUrl;
  CategoryModel({required this.title,required this.imageUrl});
}
class DummyData {
   final List<CategoryModel> allCatData = [
    CategoryModel(
      title: 'Mobile',
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Laptop',
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Fashion',
      imageUrl: 'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1498049794561-7780e7231661?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Home',
      imageUrl: 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Beauty',
      imageUrl: 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Toys',
      imageUrl: 'https://images.unsplash.com/photo-1532330393533-443990a51d10?q=80&w=200&auto=format&fit=crop',
    ),
    CategoryModel(
      title: 'Sports',
      imageUrl: 'https://images.unsplash.com/photo-1461891211039-496c91d21c1f?q=80&w=200&auto=format&fit=crop',
    ),
  ];
}

