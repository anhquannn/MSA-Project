import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/FeedBack.dart';

class feedbackHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool?> createFeedback(FeedBack fb)async{
    final url=Uri.parse('$baseUrl/feedbacks/');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
      },
        body: jsonEncode({
          'rating':fb.rating,
          'comments':fb.comments,
          'user_id':fb.user_id,
          'product_id':fb.product_id,
        })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Không thể tạo Feedback $e");
    }
    return false;
  }

  Future<FeedBack?> getFeedbackById(int id)async{
    final url=Uri.parse('$baseUrl/feedbacks/$id');
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
        final feedback=FeedBack.fromJson(data);
        return feedback;
      }
    }catch(e){
      throw Exception("Không thể lấy Feedback $e");
    }
    return null;
  }

  Future<bool?> updateFeedback(FeedBack fb)async{
    final url=Uri.parse('$baseUrl/feedbacks/${fb.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'rating':fb.rating,
            'comments':fb.comments,
            'user_id':fb.user_id,
            'product_id':fb.product_id,
          })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Không thể tạo Feedback $e");
    }
    return false;
  }

  Future<bool?> deleteFeedback(int id)async{
    final url=Uri.parse('$baseUrl/feedbacks/$id');
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
      throw Exception("Không thể xóa Feedback $e");
    }
    return false;
  }

  Future<List<FeedBack>?> getAllFeedbacksByProductID(int id)async{
    final url=Uri.parse('$baseUrl/feedbacks/product/$id');
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
        List<dynamic> data=jsonDecode(response.body);
        List<FeedBack> fb=data.map((json)=>FeedBack.fromJson(json)).toList();
        return fb;
      }
    }catch(e){
      throw Exception("Không thể lấy Feedback $e");
    }
    return null;
  }
}