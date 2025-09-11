
import 'package:ecomm_395/ui/pages/login/sign_in_page.dart';
import 'package:ecomm_395/ui/pages/signup/sign_up_page.dart';
import 'package:ecomm_395/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/home_page.dart';



class AppRoutes{

  static const String splash = '/splash';
  static const String home = '/home';
  static const String signin = '/login';
  static const String signup = '/sign_up';
  static const String dashboard_page = '/dashboard';

  static Map<String, WidgetBuilder> getRoutes() => {
    splash: (context) => SplashPage(),
    signin: (context) => SignInPage(),
    signup: (context) => SignUpPage(),
    home: (context) => HomePage(),
  };

}