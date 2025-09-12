import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/data/remote/repository/user_repo.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_bloc.dart';
import 'package:ecomm_395/ui/pages/dashboard/nav_pages/home_page.dart';
import 'package:ecomm_395/ui/pages/dashboard/nav_pages/mycart_page.dart';
import 'package:ecomm_395/ui/pages/dashboard/nav_pages/product_page.dart';
import 'package:ecomm_395/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: UserRepository(apiHelper: ApiHelper())),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.splash,

      /*home: HomePage(),*/
    );
  }
}
