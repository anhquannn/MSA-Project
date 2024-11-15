import 'package:gmarket/Http/Category.dart';

class Category{
  final String name;
  final String description;
  final int category_id;

  Category({
    required this.name,
    required this.description,
    required this.category_id
  });
  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
        name: json['name'],
        description: json['description'],
        category_id: json['ID']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name':name,
      'description':description,
      'ID':category_id,
    };
  }

}