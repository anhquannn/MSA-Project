

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:gmarket/Models/User.dart';

class userHTTP {
  final String baseUrl = 'http://192.168.1.16:8080';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> SaveToken(String token) async {
    try {
      await secureStorage.write(key: 'token', value: token);
    } catch (e) {
      throw Exception("Tải thất bại $e");
    }
  }

  Future<String?> GetToken() async {
    try {
      return await secureStorage.read(key: 'token');
    } catch (e) {
      return null;
    }
  }

  Future<void> ClearUserData() async {
    try {
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'UserId');
    } catch (e) {
      throw Exception("Xóa thất bại");
    }
  }

  Future<void> SaveUserId(String UserId) async {
    try {
      await secureStorage.write(key: 'UserId', value: UserId);
    } catch (e) {
      throw Exception("Lưu thất bại");
    }
  }

  Future<String?> GetUserId() async {
    try {
      return await secureStorage.read(key: 'UserId');
    } catch (e) {
      return null;
    }
  }

  Future<bool> LoginUser(String email, String pass) async {
    final url = Uri.parse('$baseUrl/users/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': pass}),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool?> LoginWithGoogle(String googleToken) async {
    final url = Uri.parse('$baseUrl/users/login/google');

    try {
      final response = await http.post(url,
          headers: {'Content_Type': 'application/json'},
          body: jsonEncode({'access_token': googleToken}));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = Users.fromJson(data['user']);

        await SaveToken(token);
        await SaveUserData(user, user.ID);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return false;
    }
  }

  Future<bool> RegisterUser(String FullName, String Email, String Password, String PhoneNumber, String Address,) async {
    final url = Uri.parse('$baseUrl/users/register');
    try {
      final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'fullname':FullName,
            'email': Email,
            'password': Password,
            'phonenumber': PhoneNumber,
            'address': Address,

          }));
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<int?> DeleteUser() async{
    final token= await GetToken();
    final userId= await GetUserId();
    if(token==null || userId==null){
      //khong tim thay
      return 0;
    }
    
    final url=Uri.parse('$baseUrl/users/$userId');

    try{
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );
      if(response.statusCode==200){
        return 1;
      }
    } catch(e){
      return 0;
    }
    return 0;
  }

  Future<bool?> UpdateUserInfo(String FullName, String Password, String PhoneNumber, String Email, String Address) async {
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
          'fullname': FullName,
          'phonenumber': PhoneNumber,
          'email': Email,
          'password':Password,
        }),
      );

      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
    return null;
  }

  Future<bool?> UpdateUser(String currentPassword, String newPassword) async{
    final userId= await GetUserId();
    final token=await GetToken();
    if(userId==null || token==null){
      return false;
    }
    final url=Uri.parse('$baseUrl/users/$userId/password');
     try{
       final response=await http.put(
           url,
           headers: {
             'Content-Type':'application/json',
             'Authorization':'Bearer $token'
           },
         body: jsonEncode({
           'currentpassword':currentPassword,
           'password':newPassword
         })
       );
       if(response.statusCode==200){
         final data=jsonDecode(response.body);
         final status=data['status'];
         final userData=Users.fromJson(data['user']);
         SaveUserData(userData,userData.ID);
         return true;
       }
     }catch(e){
       return false;
     }
     return false;
  }

  Future<bool?> GetNewPassWord(String email) async{
    final url=Uri.parse('$baseUrl/users/resetpass');
    try{
      final response= await http.post(
          url,
          headers: {
            'Content-Type':'application/json'
          },
          body: jsonEncode({
            'email':email
          })
      );
      if(response.statusCode==200){
        final status= jsonDecode(response.body);
        if(status==null){
          return false;
        }
        return true;
      }
    }catch(e){return false;}
    return false;
  }

  Future<bool?> UpdateUserPassword(String CurrentPassword, String NewPassword) async {
    final token = await GetToken();
    final userId = await GetUserId();

    final url = Uri.parse('$baseUrl/users/$userId/password');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentpassword': CurrentPassword,
          'password': NewPassword,
        }),
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      //Cập nhật mật khẩu thất bại
      return false;
    }
    return false;
  }

  Future<int?> verifyOTP(String otpCode) async {
    final url = Uri.parse('$baseUrl/users/verify');
    try
    {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'otp': otpCode}),
      );

      if (response.statusCode == 200) {
         final data=jsonDecode(response.body);

         final token=data['token'];
         SaveToken(token);

         final userData=Users.fromJson(data['user']);
         SaveUserData(userData, userData.ID);
         SaveUserId(userData.ID.toString());

        return 1;
      }
    } catch (e) {
      // throw Exception('Lỗi otp');
      return 0;
    }
    return 0;
  }

  Future<void> SaveUserData(Users user, int userId) async {
    try {
      // Chuyển user sang JSON và mã hóa bằng SHA-256
      final userJson = jsonEncode(user);
      final bytes = utf8.encode(userJson);
      final digest = sha256.convert(bytes);

      // Chuyển đổi hash sang chuỗi Base64 để lưu trữ
      final encrypt = base64Encode(digest.bytes);

      // Lưu trữ hash dưới dạng chuỗi Base64
      await secureStorage.write(key: userId.toString(), value: encrypt);
    } catch (e) {
      print('Error saving user data: $e');
      return;
    }
  }

  Future<Users?> ReadUserData(String userId) async{
    final encryptedData = await secureStorage.read(key: userId);
    if (encryptedData == null) return null;

    try {
      // Giải mã Base64 và chuyển đổi về chuỗi JSON
      final userJson = utf8.decode(base64Decode(encryptedData));
      final userMap = jsonDecode(userJson);

      // Tạo đối tượng Users từ JSON
      final userData = Users.fromJson(userMap);
      return userData;
    } catch (e) {
      print('Error reading user data: $e');
      return null;
    }
  }

  Future<Users?> GetUserById() async{
    final userId= await GetUserId();
    final token=await GetToken();
    if(userId==null){
      return null;
    }
    final url=Uri.parse('$baseUrl/$userId');
    try{
      final response= await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if(response.statusCode==200){
        final userData=jsonDecode(response.body);
        return Users.fromJson(userData);
      }
    } catch(e){
      return null;
    }
    return null;
  }
}
