import 'package:dio/dio.dart';

class AuthRepository{
  final Dio _dio = Dio();

  Future<String> login(String email, String password) async{
    try{
      final response = await _dio.post(
        'https://sntgold.microlanpos.com/api/login',
        data: {"email": email, "password": password},
        options: Options(
          headers: {'Content-Type': 'application/json'},

        ),
        
      );
      return response.data['token'];
    } catch (e) {
      throw Exception('Login Failed');
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try{
      await _dio.post(
        'https://sntgold.microlanpos.com/api/register',
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      throw Exception('Registration failed');
    }
  }

  Future<void> logout(String token) async {
    try{
      await _dio.post(
        'https://sntgold.microlanpos.com/api/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch(e) {
      throw Exception('Logout Failed');
    }
  }
}