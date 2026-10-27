import 'dart:async';
import 'package:ecommerce/domain/constants/app_constants.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),() async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString(AppConstants.PREF_TOKEN_KEY) ?? "";
      String nextPage = AppRoutes.PAGE_LOGIN;
      if(token.isNotEmpty){
       nextPage =  AppRoutes.PAGE_DASHBOARD;
      }
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag,size: 100,color: Colors.white,),
            SizedBox(height: 20,),
            Text('Shoppy',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 10,),
            Text('Your Shopping Partner',style: TextStyle(fontSize: 18,color: Colors.white70),),
            SizedBox(height: 30,),
            SizedBox(
              height: 30,
                width: 30,
                child: FittedBox(fit: BoxFit.fill,child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)))
          ],
        ),
      ),
    );
  }
}
