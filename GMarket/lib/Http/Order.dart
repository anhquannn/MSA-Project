import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/Order.dart';
import 'package:gmarket/Models/previewOrder.dart';
import 'package:http/http.dart' as http;


class orderHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.20.10.7:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<Order?> createOrder(Order od,String code) async{
    // /orders/?user_id=2&cart_id=2&promo_code=WANGDEPCHAI
    final url=Uri.parse('$baseUrl/orders/?user_id=${od.user_id}&cart_id=${od.cart_id}&promo_code=$code');
    final token=await userHTTP().GetToken();
    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final order=Order.fromJson(data);
        return order;
      }
    }catch(e){
      throw Exception("Không thể cập nhật đơn hàng $e");
    }
    return null;
  }

  Future<bool?> deleteOrder(int id) async{
    final url=Uri.parse('$baseUrl/orders/$id');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          }
      );
      if(response.statusCode==200) return true;
    }catch(e){
      throw Exception("Không thể xóa đơn hàng $e");
    }
    return false;
  }

  Future<Order?> getOrderById(int id)async{
    final url=Uri.parse('$baseUrl/orders/$id');
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
        final od=Order.fromJson(data);
        return od;
      }
    }catch(e){
      throw Exception("Khong the lay hoa don $e");
    }
    return null;
  }

  Future<List<Order>> getAllOrder()async{
    final url=Uri.parse('$baseUrl/orders/');
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
        final List<dynamic> data=jsonDecode(response.body);
        List<Order> list=data.map((json)=>Order.fromJson(json)).toList();
        return list;
      }
    }catch(e){
      throw Exception("Không thể load Order: $e");
    }
    return [];
  }

  Future<List<Order>> searchOrderByNumberPhone(String phoneNumber)async{
    final url=Uri.parse('$baseUrl/orders/search?phone_number=$phoneNumber');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.get(url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token',
        },
      );
      if(response.statusCode==200){
        final List<dynamic> data=jsonDecode(response.body);
        final list=data.map((json)=>Order.fromJson(json)).toList();
        print('danh sach ${list[0].status}');
        return list;
      }
    }catch(e){
      throw Exception("Không thể load Order: $e");
    }
    return [];
  }

  Future<List<Order>> getOrderHistory(int userId) async {
    final url = Uri.parse('$baseUrl/orders/history/$userId');
    final token = await userHTTP().GetToken();
    try {
      final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Order> list = data.map((json)=>Order.fromJson(json)).toList();
        return list;
      }
    } catch (e) {
      throw Exception("Khong the lay getOrderHistory $e");
    }
    return [];
  }

  Future<PreviewOrder?> getPreviewOrder(int user_id, int cart_id, String promo_code)async{
    final url=Uri.parse("$baseUrl/orders/preview-order?user_id=$user_id&cart_id=$cart_id&promo_code=$promo_code");
    final token = await userHTTP().GetToken();
    try{
      final response= await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final previewOrder=PreviewOrder.fromJson(data);
        print("Http - getPreviewOrder thanh cong $previewOrder");
        return previewOrder;
      }
    }catch(e){
      throw Exception("Http - getPreviewOrder khong thanh cong $e");
    }
    return null;
  }
}