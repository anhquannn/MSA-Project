import 'dart:convert';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';
import 'package:http/http.dart' as http;

class deliveryDetailHttp{
  String baseUrl='http://192.168.1.6:8080';

  Future<DeliveryDetail?> createDeliveryDetail(DeliveryDetail deli) async{
    final url=Uri.parse('$baseUrl/deliverydetails/');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'deliveryName':deli.deliveryName,
            'shipCode':deli.shipCode,
            'description':deli.description ,
            'weight':deli.weight ,
            'deliveryAddress':deli.deliveryAddress ,
            'deliveryContact':deli.deliveryContact ,
            'deliveryFee':deli.deliveryFee ,
            'delivery_id':deli.deliveryId ,
          })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final delivery=DeliveryDetail.fromJson(data);
        return delivery;
      }
    }catch(e){
      throw Exception("Http - Không thể createDeliveryDetail $e");
    }
    return null;
  }

  Future<DeliveryDetail?>? updateDeliveryDetail(DeliveryDetail deli) async{
    final token=await userHTTP().GetToken();
    final url=Uri.parse('$baseUrl/deliverydetails${deli.ID}');
    try{
      final response= await http.put(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token'
          },
          body: jsonEncode({
            'deliveryName':deli.deliveryName,
            'shipCode':deli.shipCode,
            'description':deli.description ,
            'weight':deli.weight ,
            'deliveryAddress':deli.deliveryAddress ,
            'deliveryContact':deli.deliveryContact ,
            'deliveryFee':deli.deliveryFee ,
          })
      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        final delivery=DeliveryDetail.fromJson(data);
        return delivery;
      }
    }catch(e){
      throw Exception("Http - Không thể updateDeliveryDetail $e");
    }
    return null;
  }

  Future<bool?> deleteDeliveryDetail(int id) async{
    final url=Uri.parse('$baseUrl/deliverydetails/$id');
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
      throw Exception("Http - Không thể deleteDeliveryDetail $e");
    }
    return false;
  }

  Future<DeliveryDetail?> getDeliveryDetailById(int id) async{
    final url=Uri.parse('$baseUrl/deliverydetails/$id');
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
        final deli=DeliveryDetail.fromJson(data);
        return deli;
      }
    }catch(e){
      throw Exception("Http - Khong the getCategoryById $e");
    }
    return null;
  }

  Future<List<DeliveryDetail>?> getAllDeliveryDetail() async{
    final url=Uri.parse('$baseUrl/deliverydetails/');
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
        List<DeliveryDetail> deli=(data).map((json)=> DeliveryDetail.fromJson(json)).toList();
        print("Http - getAllDeliveryDetail thanh cong ${deli[0].deliveryName}");
        return deli;
      }
    }catch(e){
      throw Exception("Http - Khong the getAllDeliveryDetail $e");
    }
    return null;
  }

  Future<List<DeliveryDetail>?> getAllDeliveryDetailByDeliveryId(int id) async{
    final url=Uri.parse('$baseUrl/deliverydetails/delivery/$id');
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
        List<DeliveryDetail> deli=(data).map((json)=> DeliveryDetail.fromJson(json)).toList();
        print("Http - getAllDeliveryDetailByDeliveryId thanh cong $deli");
        return deli;
      }
    }catch(e){
      throw Exception("Http - Khong the getAllDeliveryDetailByDeliveryId $e");
    }
    return null;
  }


}