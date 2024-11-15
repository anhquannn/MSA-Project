import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/FeedBack.dart';

class feedbackHttp{
  final String baseUrl = 'http://192.168.1.16:8080';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveFeedbackId(String id) async{
    try{
      await secureStorage.write(key: 'feedback_id', value: id);
    } catch(e){
      throw Exception("Ghi thất bại");
    }
  }
  Future<String?> getFeedbackId()async{
    try{
      return await secureStorage.read(key: 'feedback_id');
    }catch(e){ return null; }
  }

  Future<bool?> createFeedback(String rating, String comments, String orderId, String userId, String productId)async{
    final url=Uri.parse('$baseUrl/feedback/');

    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type':'application/json'
          },
        body: jsonEncode({
          'rating':rating,
          'comments':comments,
          'order_id':orderId,
          'user_id':userId,
          'product_id':productId
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final feedback=Feedback.fromJson(data['feedback']);
        saveFeedbackId(feedback.feedback_id.toString());
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> getFeedbackById(String id)async{
    final url=Uri.parse('$baseUrl/feedback/');

    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final feedback=Feedback.fromJson(data['feedback']);
        saveFeedbackId(feedback.feedback_id.toString());
        return true;
      }
    }catch(e){return false;}
    return false;
  }
}