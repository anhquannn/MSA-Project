import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Users {
  final String FullName;
  final String Email;
  final String Password;
  final String PhoneNumber;
  // final String BirthDay;
  final String Address;


  Users(
      {
        required this.FullName,
        required this.Email,
        required this.Password,
        required this.PhoneNumber,
        required this.Address,
       // required this.BirthDay
      });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        FullName: json['FullName'],
        Email: json['Email'],
        Password: json['Password'],
        PhoneNumber: json['PhoneNumber'],
        Address: json['Address'],
        // BirthDay: json["BirthDay"]
    );
  }
}
class UserHTTP {
  final String baseUrl = 'http://192.168.1.16:8080';

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> SaveToken(String token) async {
    try {
      await secureStorage.write(key: 'token', value: token);
    } catch (e) {
      throw Exception("Tải thất bại");
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
        final data = jsonDecode(response.body);
        final token = data['token'];
        final UserId = data['UserId'];

        if (token != null && UserId != null) {
          await SaveUserId(UserId.toString());
          await SaveToken(token);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> LoginWithGoogle(String googleToken) async {
    final url = Uri.parse('$baseUrl/users/login/google');

    try {
      final response = await http.post(url,
          headers: {'Content_Type': 'application/json'},
          body: jsonEncode({'access_token': googleToken}));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userId = data['userId'];

        if (token != null && userId != null) {
          await SaveToken(token);
          await SaveUserId(userId.toString());
          return token;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return null;
    }
  }

  Future<bool> RegisterUser(
      String FullName,
      String Email,
      String Password,
      String PhoneNumber,
      String Address,
      // String BirthDay
      ) async {
    final url = Uri.parse('$baseUrl/users/register');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'FullName':FullName,
            'Email': Email,
            'Password': Password,
            'PhoneNumber': PhoneNumber,
            'Address': Address,
            // 'BirthDay': BirthDay,

          }));
      if (response.statusCode == 201) {
        // final data = jsonDecode(response.body);
        // return data['email'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
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

  Future<void> updateUserInfo(String FullName, String Password,
      String PhoneNumber, String Email, String Address) async {
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
          'FirstName': FullName,
          'PhoneNumber': PhoneNumber,
          'Email': Email,
          'Password':Password,
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

  Future<int> UpdatePassword(
      String CurrentPassword, String NewPassword) async {
    final token = await GetToken();
    final UserId = await GetUserId();

    if (token == null || UserId == null) {
      //Thông báo phải đăng nhập
      return -1;
    }
    final url = Uri.parse('$baseUrl/users/$UserId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'CurrentPassword': CurrentPassword,
          'Password': NewPassword,
        }),
      );

      if (response.statusCode == 200) {
        return 1;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        //Sai mật khẩu hiện tại
        return -2;
      } else {
        //Cập nhật mật khẩu thất bại
        return 0;
      }
    } catch (e) {
      //Cập nhật mật khẩu thất bại
      return 0;
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

  Future<bool> verifyOTP(String otpCode) async {
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
        final data=jsonDecode(response.body);
        final token=data['token'];
        final UserId=data['UserId'];
        SaveUserId(UserId);
        SaveToken(token);
        return true;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        // throw Exception('Sai otp');
        return false;
      } else {
        // throw Exception('Xác minh otp thất bại');
        return false;
      }
    } catch (e) {
      // throw Exception('Lỗi otp');
      return false;
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  Future<Map<String, dynamic>?> GetUserDeatails() async {
    final token = await GetToken();
    final userId = await GetUserId();

    if (token == null || userId == null) {
      throw Exception('Người dùng không đăng nhập được');
    }
    final url = Uri.parse('$baseUrl/users/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Lấy thông tin người dùng thất bại');
      }
    } catch (e) {
      throw Exception('Lấy thông tin người dùng thất bại');
    }
  }

  Future<Users?> FetchUserData() async {
    final userId = await GetUserId();
    final token = await GetToken();

    final url = Uri.parse('$baseUrl/users/$userId');

    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return Users.fromJson(userData);
      } else {
        throw Exception("Lấy thông tin thất bại");
      }
    } catch (e) {
      throw Exception('Lấy thông tin thất bại: $e');
    }
  }

// Future<void> SendNewPassword(String email) async {
//   final url = Uri.parse('$baseUrl/users');
//
//   try {
//     final response = await http.post(url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({'email': email}));
//     if (response.statusCode == 200) {
//     } else {
//       throw Exception('Gửi mật khẩu mới thất bại');
//     }
//   } catch (e) {
//     throw Exception('Lỗi gửi mật khẩu $e');
//   }
// }

}
