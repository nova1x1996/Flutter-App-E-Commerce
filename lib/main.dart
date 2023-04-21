import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/page/auth/auth_login.dart';
import 'package:lab9_app_shopping/page/cart/cartPage.dart';
import 'package:lab9_app_shopping/page/category/category.dart';
import 'package:lab9_app_shopping/page/historyOder/historyOder.dart';
import 'package:lab9_app_shopping/page/home/home.dart';
import 'package:lab9_app_shopping/page/product/product.dart';
import 'package:lab9_app_shopping/providers/auth_provider.dart';
import 'package:lab9_app_shopping/providers/cart_provider.dart';
import 'package:lab9_app_shopping/providers/cate_provider.dart';
import 'package:lab9_app_shopping/providers/order_provider.dart';
import 'package:lab9_app_shopping/providers/product_provider.dart';
import 'package:lab9_app_shopping/providers/slider_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool isLogin = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          CategoryPage.router: (context) => CategoryPage(),
          ProductPage.routerName: (context) => ProductPage(),
          AuthLogin.routerName: (context) => AuthLogin(),
          CartPage.routeName: (context) => CartPage(),
          HistoryOrderPage.routeName: (context) => HistoryOrderPage(),
        },
      ),
    );
  }
}
