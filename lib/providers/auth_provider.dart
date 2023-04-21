import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token = "";
  int expires = 0;
  late Timer timer;
  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authenticaiton(String mail, String pass, String type) async {
    String url = "https://apiforlearning.zendvn.com/api/auth/login";
    try {
      var respone = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "email": mail,
          "password": pass,
        }),
      );
      var responeMap = json.decode(respone.body) as Map;
      _token = responeMap["access_token"];
      expires = responeMap["expires_in"];
      DateTime timeExpired = DateTime.now().add(Duration(seconds: expires));
      StartTimer(timeExpired);

      notifyListeners();
      var ref = await SharedPreferences.getInstance();
      var userData = jsonEncode(
          {"token": _token, "timeExpired": timeExpired.toIso8601String()});
      await ref.setString("userData", userData);
    } catch (e) {
      print(e);
    }
  }

  void login(String mail, String pass) {
    _authenticaiton(mail, pass, "Aa");
  }

  Future<void> logout() async {
    _token = "";
    expires = 0;
    notifyListeners();
    var ref = await SharedPreferences.getInstance();
    ref.remove("userData");
    EndTimer();
  }

  Future<bool> autoLogin() async {
    var ref = await SharedPreferences.getInstance();
    if (ref.containsKey("userData")) {
      // var a = json.decode(ref.getString("userData") ?? "");
      var data = jsonDecode(ref.getString("userData") ?? "");
      DateTime expires = DateTime.parse(data['timeExpired']);
      StartTimer(expires);
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkTimeLogin() async {
    var ref = await SharedPreferences.getInstance();
    var data = jsonDecode(ref.getString("userData") ?? "");
    DateTime expires = DateTime.parse(data['timeExpired']);
    if (DateTime.now().isAfter(expires)) {
      logout();
    }
  }

  void StartTimer(DateTime da) {
    var timeUntil = da.difference(DateTime.now());
    print(timeUntil);
    timer = Timer(timeUntil, () {
      checkTimeLogin();
    });
  }

  void EndTimer() {
    timer.cancel();
  }
}
