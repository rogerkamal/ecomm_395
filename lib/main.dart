import 'package:ecomm_395/data/firebase/firebase_options.dart';
import 'package:ecomm_395/data/remote/helper/api_helper.dart';
import 'package:ecomm_395/data/remote/repository/cart_repo.dart';
import 'package:ecomm_395/data/remote/repository/categories_repo.dart';
import 'package:ecomm_395/data/remote/repository/order_repo.dart';
import 'package:ecomm_395/data/remote/repository/product_repo.dart';
import 'package:ecomm_395/data/remote/repository/user_repo.dart';
import 'package:ecomm_395/domain/utils/app_routes.dart';
import 'package:ecomm_395/domain/utils/theme_provider.dart';
import 'package:ecomm_395/ui/bloc/cart_bloc/cart_bloc.dart';
import 'package:ecomm_395/ui/bloc/category_bloc/category_bloc.dart';
import 'package:ecomm_395/ui/bloc/order_bloc/order_bloc.dart';
import 'package:ecomm_395/ui/bloc/product_bloc/product_bloc.dart';
import 'package:ecomm_395/ui/bloc/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ThemeProvider()),
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: UserRepository(apiHelper: ApiHelper())),
        ),
        BlocProvider(create: (context) => ProductBloc(productRepo: ProductRepo(apiHelper: ApiHelper()))),
        BlocProvider(create: (context) => CategoriesBloc(categoriesRepo: CategoriesRepo(apiHelper: ApiHelper()))),
        BlocProvider(create: (context) => CartBloc(cartRepository: CartRepository(apiHelper: ApiHelper()))),
        BlocProvider(create: (context) => OrderBloc(orderRepository: OrderRepository(apiHelper: ApiHelper()))),
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
      title: 'ecomm',
      // theme: ThemeData.light(),
      /*darkTheme: ThemeData(),*/
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeProvider>().isDarkTheme ? ThemeMode.dark: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.splash,

      /*home: ViewAllProductsPage(),*/
    );
  }
}
