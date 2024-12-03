import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/Manufacturer.dart';

class manufacturerHttp{
  final String baseUrl='http://192.168.37.92:8080';
  final FlutterSecureStorage secureStorage=FlutterSecureStorage();
  final token="ya29.a0AeDClZDghdQHqY3r8zjelloSPLElj0sdGsgjPQsKayXs1FUfqP7bCGDg0zHubTsVY9FooZ0hY8D5PjgxbTiEJKBudX6CaJz9g6-0lx5YVRizgOK-Epr1SgomW8Xbonc3ZbI7GB2YLYAaYq8nQ7UnvxneLFyuwZMrwPT9yaZIAwaCgYKAfMSARMSFQHGX2Mifps0kFnqd5j8lumwdbV-aw0177";


  Future<void> saveManufacturerId(String id) async{
    try{
      await secureStorage.write(key: 'manufaturer_id', value: id);
    } catch(e){
      throw Exception("Ghi thất bại");
    }
  }
  Future<String?> getManufacturerId() async{
    try{
      return await secureStorage.read(key: 'manufacturer_id');
    }catch(e){ return null; }
  }

  Future<bool?> createManufaturer(String name) async{
    final url=Uri.parse('$baseUrl/manufacturers/');

    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type': 'application/json'
          },
        body:jsonEncode({
          'name': name
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final manu=Manufacturer.fromJson(data['manufacturer']);
        saveManufacturerId(manu.ID.toString());
        return true;
      }
    }catch(e){ return false; }
    return false;
  }

  Future<bool?> updateManufacturer(String id, String name, String address, String contact) async{
    final id= await getManufacturerId();
    if(id==null) return false;
    final url=Uri.parse('$baseUrl/manufacturers/$id');

    try{
      final response=await http.put(
          url,
          headers: {
            'Conent-Type':'application/json'
          },
        body: jsonEncode({
          'name':name,
          'address': address,
          'contact': contact
        })
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final manu=Manufacturer.fromJson(data['manufacturer']);
        saveManufacturerId(manu.ID.toString());
        return true;
      }
    }catch(e){ return false; }
    return false;
  }

  Future<bool?> deleteManufacturer(String id) async{
    final url=Uri.parse('$baseUrl/manufacturers/$id');

    try{
      final response=await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json'
          }
      );
      if(response.statusCode==200) return true;
    }catch(e){ return false; }
    return false;
  }

  Future<bool?> getManufacturerById(String id)async{
    final url=Uri.parse('$baseUrl/manufacturers/$id');

    try{
      final response=await http.get(
          url,
          headers: {
            'Content-Type':'application/json'
          }
      );
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final manu=Manufacturer.fromJson(data['manufacturer']);
        saveManufacturerId(manu.ID.toString());
        return true;
      }
    }catch(e){ return false; }
    return false;
  }

  Future<List<Manufacturer>> getAllManufacturer()async{
    final url=Uri.parse('$baseUrl/manufacturers/');
    // final token=userHTTP().GetToken();

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
      else{
        throw Exception("Không thể load Manufacturer: ");
      }
    }catch(e){
      throw Exception("Eror ${e}");
    }
    return [];
  }
  /*
   (GET)
      GetAllManufacturer:	/manufacturers/

			manufacturers
  */
}