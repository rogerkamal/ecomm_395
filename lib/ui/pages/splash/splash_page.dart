import 'dart:async';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm_395/domain/utils/app_constants.dart';
import 'package:ecomm_395/domain/utils/app_routes.dart';
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
    Timer(Duration(seconds: 3), () async {
      String nextPageName = AppRoutes.signin;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = prefs.getString(AppConstants.prefUserIdKey) ?? "";

      if(userToken.isNotEmpty){
        nextPageName = AppRoutes.dashboard_page;
      }

      Navigator.pushReplacementNamed(context, nextPageName);    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              /*color: Colors.blueGrey*/
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://images.unsplash.com/photo-1504672281656-e4981d70414b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              FlutterLogo(size: 100,),
              SizedBox(height: 10,),

              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Center(
                    child: Text(
                      "Splash Page",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
