
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';

class Product {
  final String? name;
  final int? price;
  final int? sales;
  final String? image;
  final int? size;
  final String? color;
  final String? specification;
  final String? description;
  final int? stocknumber;
  final String? stocklevel;
  final int? category_id;
  final int? manufacturer_id;
  final String? expiry;
  final int? ID;
  final Manufacturer? manufacturer;
  final Category? category;

  // final int sales;
  // final int feedbacks;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.size,
    required this.color,
    required this.specification,
    required this.description,
    required this.expiry,
    required this.stocknumber,
    required this.stocklevel,
    required this.category_id,
    required this.manufacturer_id,
    required this.ID,
    required this.manufacturer,
    required this.category,
    required this.sales,
  });

  factory Product.fromJson(Map<String, dynamic>json){
    return Product(
      name: json['name'],
      price:int.tryParse(json['price'].toString()),
      image: json['image'],
      size: json['size'],
      color: json['color'],
      specification: json['specification'],
      description: json['description'],
      expiry: json['expiry'],
      stocknumber: json['stocknumber'],
      stocklevel: json['stocklevel'],
      category_id: json['category_id'],
      manufacturer_id: json['manufacturer_id'],
      ID: json['ID'],
      category: Category.fromJson(json['Category']),
      manufacturer: Manufacturer.fromJson(json['Manufacturer']),
      sales:json['sales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'size': size,
      'color': color,
      'specification': specification,
      'description': description,
      'expiry': expiry,
      'stocknumber': stocknumber,
      'stocklevel': stocklevel,
      'manufacturer_id': manufacturer_id,
      'category_id': category_id,
      // 'sales':sales,
      // 'product_id':product_id,
      // 'feedbacks':feedbacks
    };
  }

}