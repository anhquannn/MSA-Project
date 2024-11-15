import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Promocode.dart';

class promoCodeHttp{
  final String baseUrl='http://192.168.1.16:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<bool?> createPromoCode(String name, String code, String description, String startDate, String endDate, String status, String discoutType, String discoutValue, String minimumOrderValue)async{
    final url=Uri.parse('$baseUrl/promocode/');
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type':'application/json'
          },
        body: jsonEncode({
          'name': name,
          'code': code,
          'description': description,
          'startdate':startDate,
          'enddate': endDate,
          'status':status,
          'discounttype': discoutType,
          'discountvalue': discoutValue,
          'minimumordervalue': minimumOrderValue
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final promo=PromoCode.fromJson(data['promocode']);
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> updatePromoCode(String id,String name, String code, String description, String startDate, String endDate, String status, String discoutType, String discoutValue, String minimumOrderValue)async{
    final url=Uri.parse('$baseUrl/promocode/$id');
    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json'
          },
          body: jsonEncode({
            'name': name,
            'code': code,
            'description': description,
            'startdate':startDate,
            'enddate': endDate,
            'status':status,
            'discounttype': discoutType,
            'discountvalue': discoutValue,
            'minimumordervalue': minimumOrderValue
          })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final promo=PromoCode.fromJson(data['promocode']);
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> deletePromoCode(String id)async{
    final url=Uri.parse('$baseUrl/promocode/$id');
    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type':'application/json'
          },
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> getPromoCodeById(String id)async{
    final url=Uri.parse('$baseUrl/promocode/$id');
    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final promo=PromoCode.fromJson(data['promocode']);
        return true;
      }
    }catch(e){return false;}
    return false;
  }
}