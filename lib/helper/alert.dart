import 'package:flutter/material.dart';

var alertLoading = AlertDialog(
    content: Row(
  children: [
    CircularProgressIndicator(),
    Container(
      margin: EdgeInsets.only(left: 15),
      child: Text("Loading..."),
    ),
  ],
));
var alertSuccess = AlertDialog(
    content: Row(
  children: [
    Icon(Icons.check),
    Container(
      margin: EdgeInsets.only(left: 15),
      child: Text("Success !!"),
    ),
  ],
));
