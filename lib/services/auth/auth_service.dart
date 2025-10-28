import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tsb_mini/models/auth/user.dart';
import 'package:tsb_mini/utils/config/base_url.dart';
import 'package:tsb_mini/utils/storage/web_auth_storage.dart';

class AuthService {

  final WebAuthStorage _storage = WebAuthStorage();
  final String _baseUrlApi = baseUrl;

  Future<User> login({required String email,required String password}) async{
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      headers: {
        'Content-Type' : 'application/json'
      },
      body: jsonEncode({
        "email" : email,
        "password" : password,
      })
    ).timeout(Duration(seconds: 30));

    final data = jsonDecode(response.body);

    // debugPrint('Response body: ${response.body}');

    if(response.statusCode == 200){
      final authUser = User.fromJson(data);

      // debugPrint('Response body: $data');

      await _storage.saveToken(authUser.token);
      await _storage.saveUserSlug(authUser.slug);
      return authUser;
    }else{
      final errorMessage = 'Unexpected error occurred. Status: ${response.statusCode}';
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async{
      final token = await _storage.getToken();
      if(token != null){
        http.post(
          Uri.parse('$_baseUrlApi/logout'),
            headers: {
              'Content-Type' : 'application/json',
              'Authorization' : 'Bearer $token'
            }
        );
        await _storage.deleteToken();
        await _storage.deleteUserSlug();
      }else{
        debugPrint('Token is invalid in logout()');
      }
    }
}