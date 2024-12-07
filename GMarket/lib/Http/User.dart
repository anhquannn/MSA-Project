

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gmarket/Models/User.dart';

class userHTTP {

  // String baseUrl='http://172.20.10.7:8080';
  // String baseUrl='http://172.22.14.98:8080';

  String baseUrl='http://192.168.1.6:8080';

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

  Future<void> saveUserData(Users user) async {
    final storage = FlutterSecureStorage();
    // Chuyển User thành JSON và lưu vào Secure Storage
    await storage.write(key: 'userData', value: jsonEncode(user.toJson()));
  }

  Future<Users?> getUserData() async {
    final storage = FlutterSecureStorage();

    // Lấy dữ liệu JSON từ Secure Storage
    final userDataJson = await storage.read(key: 'userData');
    if (userDataJson != null) {
      // Chuyển đổi JSON thành đối tượng User
      final Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return Users.fromJson(userDataMap);
    }
    return null; // Trả về null nếu không có dữ liệu
  }

  Future<bool?> LoginUser(String email, String pass) async {
    final url = Uri.parse('$baseUrl/users/login');
    email="mwang38203@gmail.com";
    pass="wangwang";
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
    } catch (e){
      throw Exception("Khong the dang nhap $e");
    }
    return false;
  }

  Future<Users?> LoginWithGoogle(String googleToken) async {
    final url = Uri.parse('$baseUrl/users/login/google');

    try {
      final response = await http.post(url,
          headers: {'Content_Type': 'application/json'},
          body: jsonEncode({'access_token': googleToken}));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token=data['token'];
        SaveToken(token);
        final user = Users.fromJson(data['user']);
        return user;
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return null;
    }
    return null;
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

  Future<bool?> DeleteUser(int id) async{
    final token= await GetToken();
    final url=Uri.parse('$baseUrl/users/$id');

    try{
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
      );
      if(response.statusCode==200){
        return true;
      }else if(response.statusCode==500){
        return false;
      }
    } catch(e){
      throw Exception("Http - Khong the xoa user $e");
    }
    return false;
  }

  Future<bool?> UpdateUserInfo(String FullName, String Password, String PhoneNumber, String Email, String Address,int id) async {
    final token = await GetToken();
    final userID = await GetUserId();

    if (token == null || userID == null) {
      throw Exception('Người dùng cần đăng nhập');
    }

    final url = Uri.parse('$baseUrl/users/$id');

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
         final userData=Users.fromJson(data['user']);
         saveUserData(userData);
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

  Future<Users?> UpdateUserPassword(String newPassword,String currentPassword, int idUser) async {
    final token = await GetToken();
    final url = Uri.parse('$baseUrl/users/$idUser/password');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentpassword': currentPassword,
          'password': newPassword,
        }),
      );
      if (response.statusCode == 200){
        final data=jsonDecode(response.body);
        final user=Users.fromJson(data);
        return user;
      }
    } catch (e) {
      throw Exception("Đổi mật khẩu thất bại");
    }
    return null;
  }

  Future<Users?> verifyOTP(String otpCode) async {
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
         print("verifyOTP get data $token");

         final userData=Users.fromJson(data['user']);
         SaveUserId(userData.ID.toString());
        return userData;
      }
    } catch (e) {
      throw Exception('Khong the dang nhap $e');
    }
    return null;
  }

  Future<Users?> GetUserById(int userId) async{
    final token=await GetToken();
    final url=Uri.parse('$baseUrl/users/$userId');
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

  Future<Users?> GetUserByNumberPhone(String numberPhone) async{
    final token=await GetToken();
    final url=Uri.parse('$baseUrl/users/phone/$numberPhone');
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

  Future<List<Users>?> getAllUser() async{
    final token=await GetToken();
    final url=Uri.parse('$baseUrl/users/');
    try{
      final response= await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if(response.statusCode==200){
        List<dynamic> userData=jsonDecode(response.body);
        List<Users> list=userData.map((json)=>Users.fromJson(json)).toList();
        return list;
      }
    } catch(e){
      return null;
    }
    return null;
  }
}
