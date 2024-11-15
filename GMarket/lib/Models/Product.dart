import 'dart:convert';
import 'dart:io';
import 'dart:ui';

class Product {
  final String? name;
  final int? price;
  final String? image;
  final int? size;
  final String? color;
  final String? specification;
  final String? description;
  final int? stocknumber;
  final String? stocklevel;
  final int? category_id;
  final int? manufacturer_id;
  // final DateTime expiry;
  final int ID;
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
    // required this.expiry,
    required this.stocknumber,
    required this.stocklevel,
    required this.category_id,
    required this.manufacturer_id,
    required this.ID,
    // required this.sales,
    // required this.feedbacks,
  });

  factory Product.fromJson(Map<String, dynamic>json){
    return Product(
        name: json['name'],
        price: json['price'],
        image: json['image'],
        size: json['size'],
        color: json['color'],
        specification: json['specification'],
        description: json['description'],
        // expiry: json['expiry'],
        stocknumber: json['stocknumber'],
        stocklevel: json['stocklevel'],
        category_id: json['category_id'],
        manufacturer_id: json['manufacturer_id'],
        ID: json['ID'],
        // sales: json['sales'],
        // feedbacks: json['feedbacks']
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'name': name,
      'price':price,
      'image':image,
      'size':size,
      'color':color,
      'specification':specification,
      'description':description,
      // 'expiry':expiry,
      'stocknumber':stocknumber,
      'stocklevel':stocklevel,
      'manufacturer_id':manufacturer_id,
      'category_id':category_id,
      // 'sales':sales,
      // 'product_id':product_id,
      // 'feedbacks':feedbacks
  };
  }
  //Chuyển hình ảnh sang base64
  // Future<String?> convertImageToBase64(File? image) async {
  //   if (image == null) return null;
  //
  //   final bytes = await image.readAsBytes(); // Đọc file thành bytes
  //   String base64String = base64Encode(bytes); // Mã hóa base64
  //   return base64String;
  // }
  //chuyển base64 sang hình ảnh
  // Image base64ToImage(String base64String) {
  //   final decodedBytes = base64Decode(base64String);
  //   return Image.memory(decodedBytes);
  // }


}
class ListProduct{
  final List<Product> listProduct;
  ListProduct({
    required this.listProduct
});
}