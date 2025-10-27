import 'package:tsb_mini/models/categories/category_model.dart';

class RewardModel{
  final String slug;
  final String name;
  final CategoryModel categorySlug;
  final int point;
  final String image;
  final String message;

  RewardModel({
    required this.slug,
    required this.name,
    required this.categorySlug,
    required this.point,
    required this.image,
    required this.message
  });

  factory RewardModel.fromJson(Map<String,dynamic> json){
    return RewardModel(
      slug : json['slug'] ?? [],
      name : json['name'] ?? [],
      categorySlug: CategoryModel.fromJson(json['categorySlug']),
      point: json['point'] ?? '',
      image: json['image'] ?? '',
      message: json['message'] ?? ''
    );
  }
}