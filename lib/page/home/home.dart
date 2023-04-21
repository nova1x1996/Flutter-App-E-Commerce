import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab9_app_shopping/page/auth/auth_login.dart';
import 'package:lab9_app_shopping/constant/constant.dart';
import 'package:lab9_app_shopping/page/cart/cartPage.dart';
import 'package:lab9_app_shopping/page/historyOder/historyOder.dart';
import 'package:lab9_app_shopping/page/home/widget/home_category.dart';
import 'package:lab9_app_shopping/page/home/widget/home_slide.dart';
import 'package:lab9_app_shopping/page/home/widget/home_special.dart';
import 'package:lab9_app_shopping/providers/auth_provider.dart';
import 'package:lab9_app_shopping/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool checkLogin;

  @override
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    var checkLogin = Provider.of<AuthProvider>(context);

    return checkLogin.isAuth
        ? HomeWidget()
        : FutureBuilder(
            future: checkLogin.autoLogin(),
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return (snapshot.data == true) ? HomeWidget() : AuthLogin();
            },
          );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                child: Image.network(
                  "https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_CMYK_Black.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home, size: 30),
                        title: const Text(
                          "Home Page",
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.history, size: 30),
                        title: const Text(
                          "History Order",
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, HistoryOrderPage.routeName);
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 30,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                        },
                      )
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, CartPage.routeName);
              },
              child: Consumer<CartProvider>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Badge(
                    alignment: AlignmentDirectional(13, -8),
                    largeSize: 19,
                    label: Text(
                      value.items.length.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          HomeSlide(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Danh mục sản phẩm",
                  style: dTextBold,
                ),
                Text(
                  "Tất cả (4)",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          HomeCategory(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sản phẩm đặc biệt",
                  style: dTextBold,
                ),
                Text(
                  "Tất cả (4)",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          HomeSpecial(),
        ],
      ),
    );
  }
}
