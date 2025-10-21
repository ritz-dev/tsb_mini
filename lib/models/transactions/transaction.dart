import 'package:tsb_mini/models/pagination_model.dart';

class Transaction {
  final PaginationModel pagination;
  final String slug;
  final String type;
  final DateTime datetime;
  final int point;
  final int pointBalance;
  final String title;
  final String relatedId;

  Transaction({
    required this.pagination,
    required this.slug,
    required this.type,
    required this.datetime,
    required this.point,
    required this.pointBalance,
    required this.title,
    required this.relatedId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      pagination: json['pagination'] is Map
          ? PaginationModel.fromJson(json['pagination'])
          : PaginationModel.empty(),
      slug: json['slug'] ?? '',
      type: json['type'] ?? '',
      datetime: DateTime.parse(json['datetime'] ?? ''),
      point: json['point'] ?? '',
      pointBalance: json['point_balance'] ?? '',
      title: json['title'] ?? '',
      relatedId: json['related_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'type': type,
      'datetime': datetime.toIso8601String(),
      'point': point,
      'point_balance': pointBalance,
      'title': title,
      'related_id': relatedId,
    };
  }
}

