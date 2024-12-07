import 'dart:convert';

import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/Cart.dart';
import 'package:http/http.dart' as http;

class cartHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';

  Future<bool?> createCart(Cart c) async{
    final url=Uri.parse('$baseUrl/carts/');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.post(
          url,
        headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
        },
        body: {
            'user_id':c.user_id,
            'status':c.status
        }
      );
      if(response.statusCode==201){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Không thể tạo giỏ hàng $e");
    }
    return null;
  }

  Future<bool?> updateCart(Cart c) async{
    final url=Uri.parse('$baseUrl/carts/${c.ID}');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: {
            'user_id':c.user_id,
            'status':c.status
          }
      );
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Không thể sửa giỏ hàng $e");
    }
    return null;
  }

  Future<bool?> deleteCart(int id) async{
    final url=Uri.parse('$baseUrl/carts/$id');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
      );
      if(response.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      Exception("Không thể xóa giỏ hàng $e");
    }
    return null;
  }

  Future<Cart?> getCartById(int id) async{
    final url=Uri.parse('$baseUrl/carts/$id');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.get(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final cart=Cart.fromJson(data);
        return cart;
      }
      else{
        return null;
      }
    }catch(e){
      Exception("Không thể lấy giỏ hàng id $id : $e");
    }
    return null;
  }

  Future<Cart?> getOrCreateCartForUser(int userId) async{
    final url=Uri.parse('$baseUrl/carts/$userId');
    final token=await userHTTP().GetToken();

    try{
      final response=await http.post(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final cart=Cart.fromJson(data);
        return cart;
      }
    }catch(e){
      Exception("Không thể lấy/tạo giỏ hàng id $userId : $e");
    }
    return null;
  }

}