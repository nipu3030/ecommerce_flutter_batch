import 'package:ecommerce/ui/dashboard/dashboard.dart';
import 'package:ecommerce/ui/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/on_boarding/ui/login/login_page.dart';
import '../../ui/on_boarding/ui/signup/signup_page.dart';

class AppRoutes {
  static const String PAGE_SPLASH = '/';
  static const String PAGE_LOGIN = '/login';
  static const String PAGE_SIGNUP = '/signup';
  static const String PAGE_DASHBOARD = '/dashboard';


  static Map<String,WidgetBuilder> mRoutes() =>  {
    PAGE_SPLASH : (_) => SplashPage(),
    PAGE_LOGIN : (_) => LoginPage(),
    PAGE_SIGNUP : (_) => SignupPage(),
    PAGE_DASHBOARD : (_) => DashboardPage()
  };
}