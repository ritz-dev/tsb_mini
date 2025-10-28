import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsb_mini/models/rewards/reward_model.dart';
import 'package:tsb_mini/utils/config/base_url.dart';

class RewardService {

  final String _baseUrlApi = baseUrl;

  Future<Map<String,String>> getHeaders() async{
    try{
      return {
        "Accept" : "application/json",
        "Content-type" : "application/json",
      };
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<RewardModel>> getAllReward() async{
    try{
      final response = await http.post(
        Uri.parse('$_baseUrlApi/rewards'),
        headers: await getHeaders(),
      );

      if(response.statusCode == 200){

        final data = jsonDecode(response.body);

        final dynamic rewardData = data is List ? data : data['data'] ?? [];

        // debugPrint("RewardData are: $rewardData");

        final reward = rewardData.map((json){

          // debugPrint("Json Data are $json");
          
          try{  
            final reJson = RewardModel.fromJson(json);
            // debugPrint("RewardData map json is $reJson");
            return reJson;
          }catch(e){
            return null;
          }
        }).whereType<RewardModel>().toList();

        // debugPrint("Reward Data in reward_service are : $reward");

        return reward;

        
      }else{
        debugPrint("Reward Status code is ${response.statusCode}");
        throw Exception("Status code is ${response.statusCode}");
      }
    }catch(e){  
      throw Exception(e.toString());
    }
  }

  Future<RewardModel> getRewardDetail(String rewardSlug) async{
    try{
      final response = await http.post(
        Uri.parse('$_baseUrlApi/rewards/detail'),
        headers: await getHeaders(),
        body: jsonEncode({
          "reward_slug" : rewardSlug,
        }),
      );

      if(response.statusCode == 200){
        final Map<String,dynamic> data = jsonDecode(response.body);

        final rewardJson = data['data'];

        debugPrint('Reward Json data is $rewardJson');

        return RewardModel.fromJson(rewardJson);
        
      }else{
        throw Exception("Reward Detail Code is ${response.statusCode}");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
