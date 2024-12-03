import 'dart:convert';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/Delivery.dart';
import 'package:http/http.dart' as http;

class deliveryHttp{
  String baseUrl='http://192.168.1.6:8080';

  Future<Delivery?> createDelivery(Delivery deli, int userId, int orderId) async{
    final url=Uri.parse('$baseUrl/deliveries/$userId/$orderId');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'status':deli.status,
            'orderId':orderId,
            'userId':userId
          })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final delivery=Delivery.fromJson(data);
        return delivery;
      }
    }catch(e){
      throw Exception("Http - Không thể createDelivery $e");
    }
    return null;
  }

  Future<Delivery?>? updateDelivery(Delivery deli) async{
    final token=await userHTTP().GetToken();
    final url=Uri.parse('$baseUrl/deliveries/${deli.ID}');
    try{
      final response= await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'status':deli.status,
          })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final delivery=Delivery.fromJson(data);
        return delivery;
      }
    }catch(e){
      throw Exception("Http - Không thể updateDelivery $e");
    }
    return null;
  }

  Future<bool?> deleteDelivery(int id) async{
    final url=Uri.parse('$baseUrl/deliveries/$id');
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
      throw Exception("Http - Không thể deleteDelivery $e");
    }
    return false;
  }

  Future<Delivery?> getDeliveryById(int id) async{
    final url=Uri.parse('$baseUrl/deliveries/$id');
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
        final deli=Delivery.fromJson(data);
        return deli;
      }
    }catch(e){
      throw Exception("Http - Khong the getCategoryById $e");
    }
    return null;
  }

}