import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsb_mini/models/categories/category_model.dart';
import 'package:tsb_mini/utils/config/base_url.dart';
import 'package:tsb_mini/utils/storage/web_auth_storage.dart';

class CategoryService {
  final WebAuthStorage _storage = WebAuthStorage();
  final String _baseUrlApi = baseUrl;

  Future<Map<String,String>> getHeaders() async{
    final String? token = await _storage.getToken();

    if(token != null){
      return {
        "Accept" : "application/json",
        "Content-Type" : "application/json",
        "Authorization" : "Bearer $token"
      };
    }else{
      debugPrint("No Token Found");
      throw Exception("No Token Found");
    }
  }

  Future<List<CategoryModel>> getAllCategory() async{
    try{
      final response = await http.post(
        Uri.parse('$_baseUrlApi/categories'),
        headers: await getHeaders(),
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final dynamic categoryData = data is List ? data : data['data'] ?? []; 
        final category = categoryData.map((json){
           try{
            // debugPrint("Category Json Data is $categoryData");
            return CategoryModel.fromJson(json);
          }catch(e){
            return null;
          }
        }).whereType<CategoryModel>().toList();

        // debugPrint("Category data is $category");
        return category;
      }else{
        debugPrint('Status Code in getAllCategory : ${response.statusCode}');
        throw Exception('Status Code in getAllCategory : ${response.statusCode}');
      }

    }catch(e){
      debugPrint('Error in getAllCategory : ${e.toString()}');
      throw Exception('Error in getAllCategory : ${e.toString()}');
    }
  }
}