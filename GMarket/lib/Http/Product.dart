import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Http/User.dart';

class productHttp{
  final String baseUrl='http://192.168.1.16:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();
   final token="ya29.a0AeDClZDxjG5FHvAsb8oiINFYHR83vYS3pBpuWXu-7Pwif-jweimh0psK3aIJlIr-A-fI6diBrAoJUdHoPZqHfPO2jkwkFnyxUUpRmp9dOiKLa2l6Yx6MnKeQKm3gMRZwvQnG7ob3e-kqzxoHf7qOoUFuN5OzyRfWfB0SsSP8aCgYKARgSARMSFQHGX2MicJRWiqgGeWp17ekVH-dDBg0175";

  //Lưu Product_id
  Future<void> saveProduct_Id(String id) async{
    try{
      await secureStorage.write(key: 'product_id', value: id);
    }catch(e){
      throw Exception('Ghi thất bại');
    }
  }
  //Lấy Product_id
  Future<String?> getProduct_Id() async{
    try{
      return await secureStorage.read(key: 'product_id');
    }catch(e){
      return null;
    }
  }

  Future<bool?> createProduct(Product product) async{
    final url=Uri.parse('$baseUrl/products/');
    final token=await userHTTP().GetToken();
    // String formattedExpiry = product.expiry.toIso8601String();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        body: jsonEncode({
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'size': product.size,
          'color': product.color,
          'specification': product.specification,
          'description': product.description,
          'stocknumber': product.stocknumber,
          'stocklevel': product.stocklevel,
          'category_id': product.category_id,
          'manufacturer_id': product.manufacturer_id,
        })

      );
      if(response.statusCode==201){
        print("Thanh cong");
        // final data=jsonDecode(response.body);
        // final product=Product.fromJson(data['product']);
        // saveProduct_Id(product.product_id.toString());
        return true;
      }
    }catch(e){
      print("loi try catch");
      throw Exception('${e}');
    }
    print("tao khong thanh cong");
    return false;
  }

  Future<bool?> UpdateProduct(String name, String price, String image, String size, String color, String specification, String description, String expiry, String stocknumber, String stocklevel, String category_id, String manufacturer_id) async{
    final productId= await getProduct_Id();
    if(productId==null) return false;
    final url=Uri.parse('$baseUrl/products/$productId');

    try{
      final response=await http.put(
          url,
        headers: {
            'Content-Type':'application/json'
        },
        body: jsonEncode({
          'name': name,
          'price': price,
          'image': image,
          'size': size,
          'color': color,
          'specification': specification,
          'description': description,
          // 'expiry': expiry,
          'stocknumber': stocknumber,
          'stocklevel': stocklevel,
          'category_id': category_id,
          'manufacturer': manufacturer_id
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final product=Product.fromJson(data['product']);
        // saveProduct_Id(product.product_id.toString());
        return true;
      }
    }catch(e){
      return false;
    }
    return false;
  }

  Future<bool?> deleteProduct(String id) async{
    final product_id= await getProduct_Id();
    if(product_id==null) return false;

    final url=Uri.parse('$baseUrl/products/$product_id');

    try{
      final response= await http.delete(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){ return false;}
  return false;
  }

  Future<bool?> getProductById(String id) async{
    final id= await getProduct_Id();
    if(id==null) return false;

    final url=Uri.parse('$baseUrl/products/$id');

    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final product=Product.fromJson(data['product']);
        // saveProduct_Id(product.product_id.toString());
        return true;
      }
    }catch(e) {return false;}
    return false;
  }

  Future<List<Product>> getAllProduct() async {
    final url = Uri.parse('$baseUrl/products/');
    //   // final user=userHTTP();
    //   // final token=await user.GetToken();
    //   // if(token==null) {
    //   //   return [];

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Đảm bảo `token` được xác định
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> list = data.map((json) => Product.fromJson(json)).toList();
        print("Lấy dữ liệu thành công");
        return list;
      } else {
        print("Lỗi: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }

  Future<List<Product>?> searchProduct(String name)async{
    final url=Uri.parse('$baseUrl/prosucts/search');
    final token=await userHTTP().GetToken();

    try{
      final responsre= await http.get(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token',
            'name':'$name'
          }
      );
      if(responsre.statusCode==200){
        final List<dynamic> data=jsonDecode(responsre.body);
        final List<Product> list=data.map((json)=>Product.fromJson(json)).toList();
        return list;
      }
    }catch(e){
      throw Exception();
    }
    return [];
  }
  /*
(GET)
FilterAndSortProduct:	/products/filter
			size, min_price, max_price, color, category_id
			status, product
  */
}

