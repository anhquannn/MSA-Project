import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Users{
  final String FirstName;
  final String LastName;
  final String PhoneNumber;
  final String Email;
  final String Address;
  final String UserId;
  final String BirthDay;

  Users({
    required this.FirstName,
    required this.LastName,
    required this.PhoneNumber,
    required this.Email,
    required this.Address,
    required this.UserId,
    required this.BirthDay
});

  factory Users.fromJson(Map<String,dynamic> json){
    return Users(
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      PhoneNumber: json['PhongNumber'],
      Email: json['email'],
      Address: json['Address'],
      UserId: json['UserId'],
      BirthDay: json["BirthDay"]
    );
  }
}

class UserHTTP{
  final String baseUrl='http://192.168.1.23:8080';

  final FlutterSecureStorage secureStorage= const FlutterSecureStorage();

  Future<void> SaveToken(String token) async{
    try{
      await secureStorage.write(key: 'token', value: token);
    }
    catch(e){
      throw Exception("Tải thất bại");
    }
  }

Future<String?> GetToken() async{
  try{
    return await secureStorage.read(key: 'token');
  }catch(e){
    return null;
  }
}

Future<void> ClearUserData() async{
    try{
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'UserId');
    } catch(e){
      throw Exception("Xóa thất bại");
    }
}

Future<void> SaveUserId(String UserId) async{
    try{
      await secureStorage.write(key: 'UserId', value: UserId);
    }catch(e){
      throw Exception("Lưu thất bại");
    }
}

Future<String?> GetUserId() async{
    try{
      return await secureStorage.read(key: 'UserId');
    }catch(e){
      return null;
    }
}

Future<String?> LoginUser(String email, String pass) async{
    final url=Uri.parse('$baseUrl/user/login');

    try{
      final response = await http.post(
          url,
          headers: {
            'Content-Type':'application/json',
      },
        body: jsonEncode({
          'email': email,
          'password': pass
        }),
      );
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final token=data['token'];
        final UserId=data['UserId'];

        if(token!=null && UserId!=null ){
          await SaveUserId(UserId.toString());
          await SaveToken(token);
          return token;
        }
        else{
          return null;
        }
      }
      else
        return null;
    }catch(e){
      return null;
    }
}
Future<String?> LoginWithGoogle(String googleToken) async{
    final url=Uri.parse('$baseUrl/user/login/google');
    
    try{
      final response=await http.post(
          url,
          headers: {'Content_Type':'application/json'},
          body: jsonEncode({'access_token': googleToken}) 
      );
      print(response.statusCode);
      
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final token=data['token'];
        final userId=data['userId'];
        
        if(token!=null && userId!=null){
          await SaveToken(token);
          await SaveUserId(userId.toString());
          return token;
        }
        else{
          return null;
        }
      }
      else{
        return null;
      }
    }catch(e){
      print('Lỗi đăng nhập: $e');
      return null;
    }
}

Future<UserInfo?> FetchUserData() async{
    final userId=await GetUserId();
    final token=await GetToken();
    
    final url=Uri.parse('$baseUrl/users/$userId');

    if(token == null){
      return null;
    }

    try{
      final response=await http.get(
          url,
        headers: {
            'Content-Type': 'application/json',
          'Authorization':'Bearer $token',
        },
      );

      if(response.statusCode==200){
        final userData = jsonDecode(response.body);
        return UserInfo.fromJson(userData);
      }
      else{
        throw Exception("Lấy thông tin thất bại");
      }
    } catch(e){
      throw Exception('Lấy thông tin thất bại: $e');
    }
}
Future<void> SendNewPassword(String email) async{
    final url =Uri.parse('$baseUrl/users');

    try{
      final response=await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
        body: jsonEncode({
          'email':email
        })
      );
      if(response.statusCode==200){

      }
      else{
        throw Exception('Gửi mật khẩu mới thất bại');
      }
    }catch(e){
      throw Exception('Lỗi gửi mật khẩu $e');
    }
}

Future<String?> RegisterUser(
    String FirstName, String LastName, String PhoneNumber, String Email, String Address, String UserId, String Password
    ) async{
    final url=Uri.parse('$baseUrl/users/register');
    try{
      final response = await http.post(
          url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'FirstName': FirstName,
          'LastName':LastName,
          'PhoneNumber': PhoneNumber,
          'Email': Email,
          'Address': Address,
          'UserId': UserId,
          'Password': Password
        })
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['email'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    }
    Future<Map<String, dynamic>?> GetUserDeatails() async{
    final token= await GetToken();
    final userId=await GetUserId();

    if(token==null || userId==null){
      throw Exception('Người dùng không đăng nhập được');
    }
    final url=Uri.parse('$baseUrl/users/$userId');

    try{
      final response=await http.get(
          url,
        headers: {
      'Content-Type':'application/json',
          'Authorization': 'Bearer $token',
      },
      );
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }
      else{
        throw Exception('Lấy thông tin người dùng thất bại');
      }
          }catch(e){
      throw Exception('Lấy thông tin người dùng thất bại');
    }
    }
    Future<void> UpdatePassword(
        String CurrentPassword, String NewPassword
        ) async{
    final token=await GetToken();
    final UserId=await GetUserId();

    if(token==null||UserId==null){
      throw Exception('Cần đăng nhập');
    }
    final url=Uri.parse('$baseUrl/users/$UserId');
    try{
      final response=await http.put(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token',
        },
        body: jsonEncode({
          'CurrentPassword':CurrentPassword,
          'Password': NewPassword,
        }),
      );

      if(response.statusCode==200){
        //
      }
      else if(response.statusCode==400||response.statusCode==401){
        throw Exception('Sai mật khẩu hiện tại');
      }else {
        throw Exception('Cập nhật mật khẩu thất bại');
      }
    }catch(e){
      throw Exception('Cập nhật mật khẩu thất bại');
    }
    }

  Future<void> updateUserInfo(String FirstName,String LastName, String PhoneNumber, String Email,String Address, String UserId, String BirthDay) async {
    final token = await GetToken();
    final userID = await GetUserId();

    if (token == null || userID == null) {
      throw Exception('Người dùng cần đăng nhập');
    }

    final url = Uri.parse('$baseUrl/users/inf/$userID');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'FirstName': FirstName,
          'LastName':LastName,
          'PhoneNumber':PhoneNumber,
          'Email':Email,
          'Address':Address,
          'UserId':UserId,
          'BirthDay': BirthDay,
        }),
      );

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {
        throw Exception('Yêu cầu không hợp lệ');
      } else {
        throw Exception('Cập nhật thông tin người dùng thất bại');
      }
    } catch (e) {
      throw Exception('Cập nhật thông tin người dùng thất bại: $e');
    }
  }
  Future<void> verifyOTP(String otpCode) async {
    final url = Uri.parse('$baseUrl/users/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'otp': otpCode}),
      );

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw Exception('Sai otp');
      } else {
        throw Exception('Xác minh otp thất bại');
      }
    } catch (e) {
      throw Exception('Lỗi otp');
    }
  }
}