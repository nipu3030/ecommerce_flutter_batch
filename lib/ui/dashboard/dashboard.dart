import 'package:ecommerce/ui/dashboard/nav_pages/nav_category_page.dart';
import 'package:ecommerce/ui/dashboard/nav_pages/nav_favourite_page.dart';
import 'package:ecommerce/ui/dashboard/nav_pages/nav_home_page.dart';
import 'package:ecommerce/ui/dashboard/nav_pages/nav_profile_page.dart';
import 'package:ecommerce/ui/dashboard/nav_pages/nav_shopping_cart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> navPages = [
    NavCategoryPage(),
    NavFavouritePage(),
    NavHomePage(),
    NavShoppingCart(),
    NavProfilePage()
  ];
  int selectedNavIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navPages[selectedNavIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            selectedNavIndex = 2;
            setState(() {
            });
          },
          child: selectedNavIndex == 2 ? Icon(Icons.home,size: 30,color: Colors.white,) :  Icon(Icons.home_outlined,size: 30,color: Colors.white,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 78,
        child: BottomAppBar(
          notchMargin: 7,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 0;
                  });
                },
                icon: selectedNavIndex == 0 ?  Icon(Icons.category,color: Colors.red,) : Icon(Icons.category_outlined,color: Colors.black,),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 1;
                  });
                },
                icon: selectedNavIndex == 1 ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border_outlined,color: Colors.black,),
              ),
              SizedBox(width: 20,),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 3;
                  });
                },
                icon: selectedNavIndex == 3 ? Icon(Icons.shopping_cart,color: Colors.red,) : Icon(Icons.shopping_cart_outlined,color: Colors.black,),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 4;
                  });
                },
                icon: selectedNavIndex == 4 ? Icon(Icons.person,color: Colors.red,) : Icon(Icons.person_outline,color: Colors.black,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
