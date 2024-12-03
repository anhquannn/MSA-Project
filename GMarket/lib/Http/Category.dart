import 'dart:convert';

import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Category.dart';

class categoryHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';

  Future<bool?> createCategory(Category cate) async{
    final url=Uri.parse('$baseUrl/categories/');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'name':cate.name,
            'description':cate.description
          })
      );
      if(response.statusCode==201){
        return true;
      }
    }catch(e){
      throw Exception("Không thể thêm loại sản phẩm $e");
    }
    return false;
  }

  Future<bool?>? updateCategory(Category cate) async{
    final token=await userHTTP().GetToken();
    final url=Uri.parse('$baseUrl/categories/${cate.ID}');
    try{
      final response= await http.put(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body: jsonEncode({
          'name': cate.name,
          'description':cate.description
        })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Không thể sửa loại sản phẩm $e");
    }
    return false;
  }

  Future<bool?> deleteCategory(int id) async{
    final url=Uri.parse('$baseUrl/categories/$id');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          }
      );
      if(response.statusCode==200) return true;
    }catch(e){
      throw Exception("Không thể sửa loại sản phẩm $e");
    }
    return false;
  }

  Future<Category?> getCategoryById(int id) async{
    final url=Uri.parse('$baseUrl/categories/$id');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final category=Category.fromJson(data);
        print('get category by id $data');
        return category;
      }
    }catch(e){
      throw Exception("Khong the lay Category $e");
    }
    return null;
  }

  Future<List<Category>> getAllCategory() async {
    final url = Uri.parse('$baseUrl/categories/');
    final token=userHTTP().GetToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body); // Giải mã JSON thành list
        List<Category> list = data.map((json) => Category.fromJson(json)).toList();
        return list;  // Trả về danh sách các đối tượng Category
      }
    } catch (e) {
      throw Exception('Không thể load loại sản phẩm $e');
    }
    return [];
  }
}