import 'package:tsb_mini/models/pagination_model.dart';

class CategoryModel {
  final PaginationModel pagination;
  final String slug;
  final String name;
  final String image;

  CategoryModel({
    required this.pagination,
    required this.slug,
    required this.name,
    required this.image
  });

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      pagination: json['pagination'] is Map ? PaginationModel.fromJson(json['pagination']) : PaginationModel.empty(),
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? ''
    );
  }
}