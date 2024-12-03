import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';

import 'package:gmarket/Models/OrderDetail.dart';
import 'package:http/http.dart' as http;


class orderDetailHttp{
  // String baseUrl='http://172.22.14.98:8080';
  String baseUrl='http://192.168.1.6:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();
  Future<bool?> createOrderDetail(OrderDetail od) async{
    final url=Uri.parse('$baseUrl/oderdetail/');
    final token=await userHTTP().GetToken();
    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body:jsonEncode({
            'status': od.status,
            'quantity': od.quantity,
            'unitprice': od.unitprice,
            'totalprice': od.totalprice,
            'order_id': od.order_id,
            'product_id': od.product_id,
          })
      );
      if(response.statusCode==201){
        return true;
      }
    }catch(e){
      throw Exception("Không thể tạo đơn hàng $e");
    }
    return false;
  }

  Future<bool?> updateOrderDetail(OrderDetail od) async{
    final url=Uri.parse('$baseUrl/oderdetail/${od.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
          headers: {
            'Conent-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'status': od.status,
            'quantity': od.quantity,
            'unitprice': od.unitprice,
            'totalprice': od.totalprice,
            'order_id': od.order_id,
            'product_id': od.product_id,
          })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Không thể cập nhật đơn hàng $e");
    }
    return false;
  }

  Future<bool?> deleteOrderDetail(int id) async{
    final url=Uri.parse('$baseUrl/oderdetail/$id');
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

  Future<OrderDetail?> getOrderDetailById(int id)async{
    final url=Uri.parse('$baseUrl/oderdetail/$id');
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
        final od=OrderDetail.fromJson(data);
        return od;
      }
    }catch(e){
      throw Exception("Khong the lay hoa don $e");
    }
    return null;
  }
}