import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfo {
  final String fullName;
  final String phoneNumber;
  final String email;

  UserInfo({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      fullName: json['fullname'],
      phoneNumber: json['phonenumber'],
      email: json['email'],
    );
  }
}
//
class UserHTTP {
  // final String baseUrl = 'https://bms-app.guarantek.com.vn';
  final String baseUrl = 'http://192.168.1.23:8080';

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    try {
      await secureStorage.write(key: 'token', value: token);
    } catch (e) {
      throw Exception('Tải dữ liệu pin thất bại');
    }
  }

  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: 'token');
    } catch (e) {
      return null;
    }
  }

  Future<void> clearUserData() async {
    try {
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'userID');
    } catch (e) {
      throw Exception('Xóa thông tin người dùng thất bại');
    }
  }

  Future<void> saveUserID(String userID) async {
    try {
      await secureStorage.write(key: 'userID', value: userID);
    } catch (e) {
      throw Exception('Lưu ID thất bại');
    }
  }

  Future<String?> getUserID() async {
    try {
      return await secureStorage.read(key: 'userID');
    } catch (e) {
      return null;
    }
  }

  Future<String?> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userID = data['userID'];

        if (token != null && userID != null) {
          await saveToken(token);
          await saveUserID(userID.toString());
          return token;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> loginWithFacebook(String facebookToken) async {
    final url = Uri.parse('$baseUrl/users/login/facebook');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'access_token': facebookToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userID = data['userID'];

        if (token != null && userID != null) {
          await saveToken(token);
          await saveUserID(userID.toString());
          return token;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error occurred during Facebook login: $e');
      return null;
    }
  }

  Future<String?> loginWithGoogle(String googleToken) async {
    final url = Uri.parse('$baseUrl/users/login/google');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'access_token': googleToken}),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final userID = data['userID'];

        if (token != null && userID != null) {
          await saveToken(token);
          await saveUserID(userID.toString());
          return token;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error occurred during Google login: $e');
      return null;
    }
  }

  Future<UserInfo?> fetchUserData() async {
    final userID = await getUserID();
    final token = await getToken();

    final url = Uri.parse('$baseUrl/users/$userID');

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
        return UserInfo.fromJson(userData);
      } else {
        throw Exception('Lấy thông tin người dùng thất bại');
      }
    } catch (e) {
      throw Exception('Lấy thông tin người dùng thất bại: $e');
    }
  }

  Future<void> sendNewPassword(String email) async {
    final url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success response
      } else {
        // Handle failure
        throw Exception('Gửi mật khẩu mới thất bại');
      }
    } catch (e) {
      throw Exception('Lỗi trong quá trình gửi mật khẩu: $e');
    }
  }

  Future<String?> registerUser(
      String fullName, String email, String password) async {
    final url = Uri.parse('$baseUrl/users/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fullname': fullName,
          'email': email,
          'password': password,
        }),
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


  Future<Map<String, dynamic>?> getUserDetails() async {
    final token = await getToken();
    final userID = await getUserID();

    if (token == null || userID == null) {
      throw Exception('User is not authenticated');
    }

    final url = Uri.parse('$baseUrl/users/$userID');

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

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final token = await getToken();
    final userID = await getUserID();

    if (token == null || userID == null) {
      throw Exception('Người dùng cần đăng nhập');
    }

    final url = Uri.parse('$baseUrl/users/$userID');

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

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw Exception('Sai mật khẩu hiện tại');
      } else {
        throw Exception('Cập nhật mật khẩu thất bại');
      }
    } catch (e) {
      throw Exception('Cập nhật mật khẩu thất bại');
    }
  }

  Future<void> updateUserInfo(String fullName, String phoneNumber, String email) async {
    final token = await getToken();
    final userID = await getUserID();

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
          'fullname': fullName,
          'phonenumber': phoneNumber,
          'email': email,
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