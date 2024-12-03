import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Promocode.dart';

class promoCodeHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<bool?> createPromoCode(PromoCode pc)async{
    final url=Uri.parse('$baseUrl/promocodes/');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization': 'Bearer $token',
          },
        body: jsonEncode({
          'name': pc.name,
          'code': pc.code,
          'description': pc.description,
          'startdate':pc.startdate,
          'enddate': pc.enddate,
          'status':pc.status,
          'discounttype': pc.discounttype,
          'discountpercentage': pc.discountpercentage,
          'minimumordervalue': pc.minimumordervalue
        })
      );
      if(response.statusCode==201){
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> updatePromoCode(PromoCode pc)async{
    final url=Uri.parse('$baseUrl/promocodes/${pc.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'name': pc.name,
            'code': pc.code,
            'description': pc.description,
            'startdate':pc.startdate,
            'enddate': pc.enddate,
            'status':pc.status,
            'discounttype': pc.discounttype,
            'discountvalue': pc.discountpercentage,
            'minimumordervalue': pc.minimumordervalue
          })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Không thể cập nhật $e");
    }
    return false;
  }

  Future<bool?> deletePromoCode(int id)async{
    final url=Uri.parse('$baseUrl/promocodes/$id');
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
    }catch(e){
      throw Exception("Không thể lấy xóa $e");
    }
    return false;
  }

  Future<PromoCode?> getPromoCodeById(int id)async{
    final url=Uri.parse('$baseUrl/promocodes/$id');
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
        print("ok1");
        final data=jsonDecode(response.body);
        print("ok2");
        final promo=PromoCode.fromJson(data);
        print("ok3");
        return promo;
      }
    }catch(e){
      throw Exception("Không thể lấy bằng Id $e");
    }
    return null;
  }

  Future<PromoCode?> getPromocodeByCode(String code) async{
    final url=Uri.parse('$baseUrl/promocodes/code/$code');
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
        final promo=PromoCode.fromJson(data);
        return promo;
      }
    }catch(e){
      throw Exception("Không thể lấy bằng Code: $code -:- $e");
    }
    return null;
  }

  Future<List<PromoCode>?> getAllPromoCode() async{
    final url=Uri.parse('$baseUrl/promocodes/');
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
        List<dynamic> data=jsonDecode(response.body);
        List<PromoCode> promo=data.map((json)=>PromoCode.fromJson(json)).toList();
        return promo;
      }
    }catch(e){
      throw Exception("Không thể lấy getAllPromoCode -:- $e");
    }
    return null;
  }
}