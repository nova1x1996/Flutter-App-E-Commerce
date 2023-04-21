import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab9_app_shopping/page/category/widget/category_home.dart';

class CategoryPage extends StatelessWidget {
  static const router = "/category";
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var paramRoute = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(paramRoute["name"]),
        centerTitle: true,
      ),
      body: CategoryHome(),
    );
  }
}
