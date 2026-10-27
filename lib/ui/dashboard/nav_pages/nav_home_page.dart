import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_bloc.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_event.dart';
import 'package:ecommerce/ui/dashboard/bloc/product_state.dart';
import 'package:ecommerce/ui/dashboard/dummy_page.dart';
import 'package:ecommerce/ui/widgets/show_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavHomePage extends StatefulWidget{

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  List<String> bannerUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyxa-eLd8zev29fJrS3QzTlELGkqngF4JKEplyHrpWRQ&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsd4kK67BG6vp6UqWDFpKsaJB0YMRgrK_6hRibt3FyLg&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREodNODEQbv_Dz9x3Ai7rubEGfxnfJ7gSon57P6xWZ0Q&s=10",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQALWckVvDJ-vIcC-y-wEq7bJrH-aHb-c3ky2BIvwxCZw&s=10"
  ];
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }

  @override
  Widget build(context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: (){},
                        icon: Icon(Icons.menu),
                    style: IconButton.styleFrom(
                      iconSize: 23,
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.grey.shade300,
                      shape: CircleBorder()
                    ),),
                    Spacer(),
                    IconButton(onPressed: (){},
                        icon: Icon(Icons.notifications),
                    style: IconButton.styleFrom(
                      iconSize: 23,
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.grey.shade300,
                      shape: CircleBorder()
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                SearchBar(
                  hintText: 'Search...',
                  padding: WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)
                  ),
                  elevation: WidgetStateProperty.all(0),
                  leading: Icon(Icons.search),
                  trailing: [
                    Icon(Icons.vertical_align_top),
                    SizedBox(width: 20,),
                    Icon(Icons.menu)
                  ]
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: CarouselSlider.builder(itemCount: bannerUrls.length,
                      itemBuilder: (_,index,_){
                       return Container(
                         margin: EdgeInsets.symmetric(horizontal: 10),
                         width: double.infinity,
                         height: 250,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(21),
                           image: DecorationImage(image: NetworkImage(bannerUrls[index]),fit: BoxFit.cover)
                         ),
                       );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1
                      )),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: DummyData().allCatData.length,
                    itemBuilder: (_,index){
                      var data = DummyData().allCatData[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(data.imageUrl),
                            ),
                            SizedBox(height: 10,),
                            Text(data.title,style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Text('Special For You',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                    Spacer(),
                    Text('See all',style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10,),
                BlocBuilder<ProductBloc,ProductState>(
                  builder: (_,state){
                    if(state is ProductLoadingState){
                      return CircularProgressIndicator.adaptive();
                    }
                    if(state is ProductLoadedState){
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.allProduct.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20),
                          itemBuilder: (_,index){
                            var product = state.allProduct[index];
                            return ShowProducts(product: product);
                          });
                    }
                    if(state is ProductFailureState){
                      return Text(state.errorMsg);
                    }
                    return Text('No Product Found!');
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}