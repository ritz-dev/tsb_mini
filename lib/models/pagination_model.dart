// PaginationModel_model.dart
class PaginationModel {
  final int page;
  final int limit;
  final int totalPages;
  final int totalRecords;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalRecords,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'],
      limit: json['limit'],
      totalPages: json['total_pages'],
      totalRecords: json['total_records'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total_pages': totalPages,
      'total_records': totalRecords,
    };
  }
  static PaginationModel empty() {
    return PaginationModel(
      page: 0,
      limit: 0,
      totalPages: 0,
      totalRecords: 0,
    );
  }
}
