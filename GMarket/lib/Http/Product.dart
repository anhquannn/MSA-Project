import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Http/User.dart';

class productHttp{
  // String baseUrl='http://172.20.10.2:8080';
  String baseUrl='http://192.168.1.6:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<bool?> createProduct(Product product) async{
    final url=Uri.parse('$baseUrl/products/');
    final token=await userHTTP().GetToken();
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
            'expiry':product.expiry,
          })
      );
      if(response.statusCode==201){
        print("Thanh cong");
        return true;
      }
    }catch(e){
      throw Exception("Tao san phan khong thanh cong $e");
    }
    return false;
  }

  Future<bool?> UpdateProduct(Product product) async{
    final url=Uri.parse('$baseUrl/products/${product.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
        headers: {
            'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body: jsonEncode({
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'size': product.size,
          'color': product.color,
          'specification': product.specification,
          'description': product.description,
          'expiry': product.expiry,
          'stocknumber': product.stocknumber,
          'stocklevel': product.stocklevel,
          'category_id': product.category_id,
          'manufacturer_id': product.manufacturer_id
        })
      );
      if(response.statusCode==200){
        print("Sửa thành công");
        return true;
      }
    }catch(e){
      throw Exception("Sửa không thành công $e");
    }
    return false;
  }

  Future<bool?> deleteProduct(int id) async{
    final token=await userHTTP().GetToken();
    final url=Uri.parse('$baseUrl/products/$id');

    try{
      final response= await http.delete(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          }
      );
      if(response.statusCode==200){
        print("Xóa thành công");
        return true;
      }
    }catch(e){
      throw Exception("Xóa không thành công $e");
    }
  return false;
  }

  Future<Product?> getProductById(int id) async{
    final url=Uri.parse('$baseUrl/products/$id');
    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json',
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final product=Product.fromJson(data);
        return product;
      }
    }catch(e){
      throw Exception('Không thể lấy dữ liệu $e');
    }
    return null;
  }

  Future<List<Product>> getAllProduct() async {
    final url = Uri.parse('$baseUrl/products/');
    final token=await userHTTP().GetToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Product> list = data.map((json) => Product.fromJson(json)).toList();
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
    final url = Uri.parse('$baseUrl/products/search?name=$name');
    // final url=Uri.parse('$baseUrl/products/search');
    final token=await userHTTP().GetToken();

    try{
      final responsre= await http.get(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token',
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

  Future<List<Product>?> filterProducts(int page)async {
    final url=
    Uri.parse('$baseUrl/products/filter?page=$page&pageSize=10');

    try{
      final response= await http.get(url);
      if(response.statusCode==200){
        final List<dynamic> data=jsonDecode(response.body);
        final List<Product> list=data.map((json)=>Product.fromJson(json)).toList();
        print("Http - filterAndSortProducts thanh cong");
        return list;
      }
    }catch(e){
      throw Exception("Http - Khong the filterAndSortProducts $e");
    }
    return [];
  }

  // Future<List<Product>?> SortProducts(int size, int minPrice, int maxPrice, int categoryId, int page, int pageSize)async{
  //   if(size==0){
  //     final url= Uri.parse('$baseUrl/products/filter?&min_price=$minPrice&max_price=$maxPrice&category_id=$categoryId&page=$page&pageSize=10');
  //     try{
  //       final response= await http.get(url);
  //       if(response.statusCode==200){
  //         final List<dynamic> data=jsonDecode(response.body);
  //         final List<Product> list=data.map((json)=>Product.fromJson(json)).toList();
  //         print("Http - filterAndSortProducts thanh cong");
  //         return list;
  //       }
  //     }catch(e){
  //       throw Exception("Http - Khong the filterAndSortProducts $e");
  //     }
  //   }
  //   else if(categoryId==0){
  //     final url= Uri.parse('$baseUrl/products/filter?size=$size&min_price=$minPrice&max_price=$maxPrice&page=$page&pageSize=10');
  //     try{
  //       final response= await http.get(url);
  //       if(response.statusCode==200){
  //         final List<dynamic> data=jsonDecode(response.body);
  //         final List<Product> list=data.map((json)=>Product.fromJson(json)).toList();
  //         print("Http - filterAndSortProducts thanh cong");
  //         return list;
  //       }
  //
  //     }catch(e){
  //       throw Exception("Http - Khong the filterAndSortProducts $e");
  //     }
  //   }else{
  //     final url= Uri.parse('$baseUrl/products/filter?size=$size&min_price=$minPrice&max_price=$maxPrice&category_id=$categoryId&page=$page&pageSize=10');
  //     try{
  //       final response= await http.get(url);
  //       if(response.statusCode==200){
  //         final List<dynamic> data=jsonDecode(response.body);
  //         final List<Product> list=data.map((json)=>Product.fromJson(json)).toList();
  //         print("Http - filterAndSortProducts thanh cong");
  //         return list;
  //       }
  //     }catch(e){
  //       throw Exception("Http - Khong the filterAndSortProducts $e");
  //     }
  //   }
  //   return [];
  // }

  Future<List<Product>?> SortProducts({
    int? size,
    int? minPrice,
    int? maxPrice,
    int? categoryId,
    int? page,
    int? pageSize,
  }) async {
    // Khởi tạo query parameters
    final queryParameters = {
      if (size != null && size > 0) 'size': size.toString(),
      if (minPrice != null) 'min_price': minPrice.toString(),
      if (maxPrice != null) 'max_price': maxPrice.toString(),
      if (categoryId != null && categoryId > 0) 'category_id': categoryId.toString(),
      if (page != null && page > 0) 'page': page.toString(),
      if (pageSize != null && pageSize > 0) 'pageSize': pageSize.toString(),
    };

    final uri = Uri.parse('$baseUrl/products/filter').replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<Product> list = data.map((json) => Product.fromJson(json)).toList();
        print("Http - filterAndSortProducts thành công");
        return list;
      } else {
        print("Http - Lỗi khi gọi API: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception("Http - Không thể filterAndSortProducts $e");
    }
  }




}




