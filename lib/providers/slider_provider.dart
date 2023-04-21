import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab9_app_shopping/models/slider_model.dart';
import 'package:http/http.dart' as http;

class SliderProvider extends ChangeNotifier {
  Future<List<SliderModel>> getSlider() async {
    String url = "https://apiforlearning.zendvn.com/api/mobile/sliders";
    try {
      var respone = await http.get(Uri.parse(url));
      var listMap = jsonDecode(respone.body) as List;
      var result = listMap.map((e) => SliderModel.fromMap(e)).toList();
      return result;
    } catch (e) {
      return Future.error("nodata");
    }
  }
}
