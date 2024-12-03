import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Manufacturer.dart';

class manufacturerHttp{
  String baseUrl='http://192.168.1.6:8080';
  // String baseUrl='http://172.22.14.98:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();

  Future<bool?> createManufaturer(Manufacturer manu) async{
    final url=Uri.parse('$baseUrl/manufacturers/');
    final token=await userHTTP().GetToken();
    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
        body:jsonEncode({
          'name': manu.name,
          'address': manu.address,
          'contact': manu.contact,
        })
      );
      if(response.statusCode==201){
        return true;
      }
    }catch(e){
      throw Exception("Khong the lay Nha san xuat $e");
    }
    return false;
  }

  Future<bool?> updateManufacturer(Manufacturer manu) async{
    final url=Uri.parse('$baseUrl/manufacturers/${manu.ID}');
    final token=await userHTTP().GetToken();
    try{
      final response=await http.put(
          url,
          headers: {
            'Conent-Type':'application/json',
            'Authorization':'Bearer $token'
          },
        body: jsonEncode({
          'name':manu.name,
          'address': manu.address,
          'contact': manu.contact
        })
      );
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      throw Exception("Khong the cap nhat Nha san xuat $e");
    }
    return false;
  }

  Future<bool?> deleteManufacturer(int id) async{
    final url=Uri.parse('$baseUrl/manufacturers/$id');
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
      throw Exception("Khong the xoa Nha san xuat $e");
    }
    return false;
  }

  Future<Manufacturer?> getManufacturerById(int id)async{
    final url=Uri.parse('$baseUrl/manufacturers/$id');
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
        final manu=Manufacturer.fromJson(data);
        return manu;
      }
    }catch(e){
      throw Exception("Khong the lay Nha san xuat $e");
    }
    return null;
  }

  Future<List<Manufacturer>> getAllManufacturer()async{
    final url=Uri.parse('$baseUrl/manufacturers/');
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
        List<Manufacturer> list=data.map((json)=>Manufacturer.fromJson(json)).toList();
        return list;
      }
    }catch(e){
      throw Exception("Không thể load Manufacturer: $e");
    }
    return [];
  }
}