import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  int id;
  String name;
  String image;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
