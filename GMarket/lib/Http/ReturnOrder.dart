import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/ReturnOrder.dart';
import 'package:http/http.dart' as http;


class returnOrderHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<ReturnOrder?> createReturnOrder(ReturnOrder ro) async{
    final url=Uri.parse('$baseUrl/returnorders/${ro.orderId}');
    final token=await userHTTP().GetToken();
    try{
      final response= await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':'Bearer $token'
        },
        body: jsonEncode({
          "status": "status",
          "reason": ro.reason,
          "refundamount": 1,
        })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final order=ReturnOrder.fromJson(data);
        return order;
      }
    }catch(e){
      throw Exception("Không thể createReturnOrder $e");
    }
    return null;
  }

  Future<List<ReturnOrder>> getAllReturnOrder()async{
    final url=Uri.parse('$baseUrl/returnorders/all');
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
        List<ReturnOrder> list=data.map((json)=>ReturnOrder.fromJson(json)).toList();
        return list;
      }
    }catch(e){
      throw Exception("Không thể load getAllReturnOrder: $e");
    }
    return [];
  }

}