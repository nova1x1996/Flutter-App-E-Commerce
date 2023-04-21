import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product> listProductSpecial = [];

  Future<List<Product>> getProductsSpecial() async {
    String url =
        "https://apiforlearning.zendvn.com/api/mobile/products?offset=0&sortBy=id&order=asc&special=true";
    var respone = await http.get(Uri.parse(url));
    var listMap = jsonDecode(respone.body) as List;
    var result = listMap.map((e) => Product.fromMap(e)).toList();
    return result;
  }

  Future<Product> getProduct(int id) async {
    String url = "http://apiforlearning.zendvn.com/api/mobile/products/$id";

    try {
      var respone = await http.get(Uri.parse(url));
      var StringResult = jsonDecode(respone.body);
      var model = Product.fromMap(StringResult);

      return model;
    } catch (e) {
      return Future.error(e);
    }
  }
}
