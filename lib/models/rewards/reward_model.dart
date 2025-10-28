import 'package:tsb_mini/models/categories/category_model.dart';
import 'package:tsb_mini/models/pagination_model.dart';

class RewardModel{
  final PaginationModel pagination;
  final String slug;
  final String name;
  final CategoryModel categorySlug;
  final int point;
  final String image;
  final String message;

  RewardModel({
    required this.pagination,
    required this.slug,
    required this.name,
    required this.categorySlug,
    required this.point,
    required this.image,
    required this.message
  });

  factory RewardModel.fromJson(Map<String,dynamic> json){
    return RewardModel(
      pagination: json['pagination'] is Map ? PaginationModel.fromJson(json['pagination']) : PaginationModel.empty(),
      slug : json['slug'] ?? [],
      name : json['name'] ?? [],
      categorySlug: CategoryModel(
        slug: json['category_slug'],
        name: json['category_name'] ?? '',
        image: json['category_image'] ?? '',
        pagination: json['category_pagination'] is Map ? PaginationModel.fromJson(json['category_pagination']) : PaginationModel.empty(),
      ),
      point: json['point'] ?? '',
      image: json['image'] ?? '',
      message: json['message'] ?? ''
    );
  }
}