import 'package:ecomm_395/utils/app_routes.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("User Profile"),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.signin);
            },
            child: Icon(Icons.logout,fontWeight: FontWeight.bold, size: 35,color: Colors.black,),
          ),

        ],
      )),
      body: Column(),
    );
  }
}
