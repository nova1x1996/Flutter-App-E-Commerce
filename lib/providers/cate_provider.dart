import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/models/category_model.dart';
import 'package:lab9_app_shopping/models/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  Future<List<CategoryModel>> getCategory() async {
    String url = "https://apiforlearning.zendvn.com/api/mobile/categories";
    try {
      var respone = await http.get(Uri.parse(url));
      var listMap = jsonDecode(respone.body) as List;
      var result = listMap.map((e) => CategoryModel.fromMap(e)).toList();
      return result;
    } catch (e) {
      return Future.error("Error !!!");
    }
  }

  Future<List<Product>> getProductInCategory(int id) async {
    String url =
        "https://apiforlearning.zendvn.com/api/mobile/categories/${id.toString()}/products";
    try {
      var respone = await http.get(Uri.parse(url));
      var listMap = jsonDecode(respone.body) as List;
      var result = listMap.map((e) => Product.fromMap(e)).toList();
      return result;
    } catch (e) {
      return Future.error("Error !!!");
    }
  }
}
