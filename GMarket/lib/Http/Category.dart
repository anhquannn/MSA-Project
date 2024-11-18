import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Category.dart';

class categoryHttp{
  final String baseUrl='http://192.168.37.92:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();
  final token="ya29.a0AeDClZDghdQHqY3r8zjelloSPLElj0sdGsgjPQsKayXs1FUfqP7bCGDg0zHubTsVY9FooZ0hY8D5PjgxbTiEJKBudX6CaJz9g6-0lx5YVRizgOK-Epr1SgomW8Xbonc3ZbI7GB2YLYAaYq8nQ7UnvxneLFyuwZMrwPT9yaZIAwaCgYKAfMSARMSFQHGX2Mifps0kFnqd5j8lumwdbV-aw0177";


  Future<void> saveCategoryId(String id) async{
    try{
      await secureStorage.write(key: 'categoryId', value: id);
    }catch(e){
      throw Exception('Ghi thất bại');
    }
  }

  Future<String?> getCategoryId()async{
    try{
      return await secureStorage.read(key: 'categoryId');
    }catch(e){ return null;}
  }

  Future<bool?> createCategory(String name) async{
    final url=Uri.parse('$baseUrl/categories');

    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'name':name
          })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final category=Category.fromJson(data['category']);
        saveCategoryId(category.category_id.toString());
        return true;
      }
    }catch(e){ return false; }
    return false;
  }

  Future<bool?>? updateCategory(String name, String description) async{
    final id= await getCategoryId();
    if(id==null) return false;
    final url=Uri.parse('$baseUrl/categories/$id');

    try{
      final response= await http.put(
        url,
        headers: {
          'Content-Type':'application/json'
        },
        body: jsonEncode({
          'name': name,
          'description':description
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final category=Category.fromJson(data['category']);
        saveCategoryId(category.category_id.toString());
        return true;
      }
    }catch(e){ return false; }
    return false;
  }

  Future<bool?> deleteCategory(String id) async{
    final url=Uri.parse('$baseUrl/categories/$id');

    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200) return true;
    }catch(e){ return false; }
    return false;
  }

  Future<bool?> getCategoryById(String id) async{
    final url=Uri.parse('$baseUrl/categories/$id');

    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final category=Category.fromJson(data['category']);
        saveCategoryId(category.category_id.toString());
        return true;
      }
    }catch(e){ return false;}
    return false;
  }

  Future<List<Category>> getAllCategory() async {
    final url = Uri.parse('$baseUrl/categories/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Kiểm tra mã trạng thái HTTP
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body); // Giải mã JSON thành list
        List<Category> list = data.map((json) => Category.fromJson(json)).toList();
        return list;  // Trả về danh sách các đối tượng Category
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // In ra thông tin lỗi chi tiết
      print('Error fetching categories: $e');
      throw Exception('Error fetching categories');
    }
  }

}