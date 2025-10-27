import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsb_mini/models/transactions/transaction_model.dart';
import 'package:tsb_mini/utils/config/base_url.dart';
import 'package:tsb_mini/utils/storage/web_auth_storage.dart';

class TransactionService {

  final WebAuthStorage _storage = WebAuthStorage();
  final String _baseUrlApi = baseUrl;

  Future<Map<String,String>> getHeaders() async{
    final String? token = await _storage.getToken();

    debugPrint("Token in Header getAllTransaction : $token");

    if(token != null){
      return {
        "Content-Type" : "application/json",
        "Accept" : "application/json",
        "Authorization" : "Bearer $token"
      };
    }else{
      debugPrint("No Token Found");
      throw Exception("No Token Found");
    }
  }
  
  Future<List<TransactionModel>> getAllTransaction() async{
    final String? userSlug = await _storage.getUserSlug();

    debugPrint("User Slug is $userSlug");

    if (userSlug == null) {
      debugPrint('❌ userSlug is null — cannot fetch transactions');
      throw Exception('User slug not found. Please log in again.');
    }

    try{
      final response = await http.post(
        Uri.parse('$_baseUrlApi/transactions'),
        headers: await getHeaders(),
        body: jsonEncode({
          'user_slug' : userSlug
        })
      );

      debugPrint("User Slug response is $userSlug");

      debugPrint("response in getAllTransaction : ${response.body}");

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final dynamic jsonData = data is List ? data : data['data'] ?? [];
        final transaction = jsonData.map((json){
          try{
            return TransactionModel.fromJson(json);
          }catch(e){
            return null;
          }
        }).whereType<TransactionModel>()
          .toList();

          debugPrint('$transaction');

          return transaction;
      }else{
        debugPrint('Status Code in getAllTransaction : ${response.statusCode}');
        throw Exception('Status Code in getAllTransaction : ${response.statusCode}');
      }
    }catch(e){
      debugPrint('Error in getAllTransaction : ${e.toString()}');
      throw Exception('Error in getAllTransaction : ${e.toString()}');
    }
  }
}