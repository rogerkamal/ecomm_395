
import 'package:flutter/material.dart';

import '../ui/home_page.dart';
import '../ui/sign_in_page.dart';
import '../ui/sign_up_page.dart';
import '../ui/splash_page.dart';


class AppRoutes{

  static const String splash = '/splash';
  static const String home = '/home';
  static const String signin = '/login';
  static const String signup = '/register';

  static Map<String, WidgetBuilder> getRoutes() => {
    splash: (context) => SplashPage(),
    signin: (context) => SignInPage(),
    signup: (context) => SignUpPage(),
    home: (context) => HomePage(),
  };

}