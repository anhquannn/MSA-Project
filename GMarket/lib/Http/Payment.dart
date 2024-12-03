
import 'dart:convert';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/Payment.dart';
import 'package:http/http.dart' as http;

class paymentHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';

  Future<Payment?> createPayment(Payment pay) async{
    final url=Uri.parse('$baseUrl/payments/${pay.user_id}/${pay.order_id}');
    final token=await userHTTP().GetToken();
    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body:jsonEncode({
            'paymentmethod': pay.paymentmethod,
            'status': pay.status,
            'grandtotal': pay.grandtotal,
          })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final payment=Payment.fromJson(data);
        return payment;
      }
    }catch(e){
      throw Exception("Http - Khong the tao payment $e");
    }
    return null;
  }

  Future<Payment?> updatePayment(Payment pay) async{
    final url=Uri.parse('$baseUrl/payments/${pay.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
          headers: {
            'Conent-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'paymentmethod': pay.paymentmethod,
            'status': pay.status,
            'grandtotal': pay.grandtotal,
          })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final payment=Payment.fromJson(data);
        return payment;
      }
    }catch(e){
      throw Exception("Http - Khong the update payment $e");
    }
    return null;
  }

  Future<bool?> deletePayment(int id) async{
    final url=Uri.parse('$baseUrl/payments/${id}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          }
      );
      if(response.statusCode==200)
        return true;
    }catch(e){
      throw Exception("Http - Khong the xoa Payment $e");
    }
    return false;
  }

  Future<Payment?> getPaymentByID(int id)async{
    final url=Uri.parse('$baseUrl/payments/$id');
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
        final payment=Payment.fromJson(data);
        return payment;
      }
    }catch(e){
      throw Exception("Http - Khong the lay payment $e");
    }
    return null;
  }

  Future<List<Payment>> getAllPayments()async{
    final url=Uri.parse('$baseUrl/payments/all');
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
        List<Payment> list=data.map((json)=>Payment.fromJson(json)).toList();
        return list;
      }
    }catch(e){
      throw Exception("Http - Không thể load Payment: $e");
    }
    return [];
  }

}