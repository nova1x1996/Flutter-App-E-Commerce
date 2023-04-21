import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier {
  Future<bool> buy(Map<int, dynamic> items) async {
    var ref = await SharedPreferences.getInstance();
    var UserData = jsonDecode(ref.getString("userData") ?? "");
    var token = UserData["token"];

    List data = [];
    items.forEach((key, value) {
      data.add(
        {
          "product_id": key,
          "quantity": value.quantity,
        },
      );
    });

    //Gửi yêu cầu mua hàng lên api
    String url = "http://apiforlearning.zendvn.com/api/mobile/orders/save";
    try {
      var respone = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Authorization": "bearer $token",
        },
        body: jsonEncode({"data": data}),
      );
      if (respone.statusCode != 201) {
        return false;
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> getListOrder() async {
    String url = "http://apiforlearning.zendvn.com/api/mobile/orders";

    try {
      var ref = await SharedPreferences.getInstance();
      var UserData = jsonDecode(ref.getString("userData") ?? "");

      var respone = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Authorization": "bearer ${UserData["token"]}"
        },
      );
      if (respone.statusCode == 200) {
        var listOrder = jsonDecode(respone.body) as List;
        return listOrder;
      }
      return [];
    } catch (e) {
      return Future.error(e);
    }
  }
}
