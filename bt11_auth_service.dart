import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://dummyjson.com/auth';

  /// LOGIN — trả về accessToken nếu thành công
  static Future<String?> login(String username, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 30, // Token hết hạn sau 30 phút
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['accessToken'];
      }
    } catch (e) {
      print('Lỗi login: $e');
    }
    return null;
  }

  /// GET PROFILE
  static Future<Map<String, dynamic>?> getProfile(String token) async {
    try {
      final url = Uri.parse('$baseUrl/me');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Quan trọng: Gửi token lên server
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Lỗi lấy profile: $e');
    }
    return null;
  }
}
