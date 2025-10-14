import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/frame/body/history/list_view_frame.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class CreditList extends StatefulWidget {
  final String? startDate;
  final String? endDate;

  const CreditList({super.key, this.startDate, this.endDate});

  @override
  State<CreditList> createState() => _CreditListState();
}

class _CreditListState extends State<CreditList> {
  List<Map<String, dynamic>> items = [
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Mr. John Doe',
      'status': 'increase',
      'point': 380,
      'date': '14 Aug, 2025',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Reward Exchange',
      'from_name': 'Travel & Tour',
      'status': 'decrease',
      'point': 124,
      'date': '13 Aug, 2025',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 1',
      'status': 'increase',
      'point': 70,
      'date': '11 Aug, 2025',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer Out',
      'from_name': 'Mr. John Doe',
      'status': 'decrease',
      'point': 240,
      'date': '10 Aug, 2025',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Reward Exchange',
      'from_name': 'Food',
      'status': 'decrease',
      'point': 100,
      'date': '8 Aug, 2025',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Reward Exchange',
      'from_name': 'Drink',
      'status': 'decrease',
      'point': 124,
      'date': '5 Aug, 2025',
    },
  ];

  late List<Map<String, dynamic>> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = _applyFilter();

    for (var fil in filteredItems) {
      debugPrint(fil['status'].toString());
    }

    // for (var item in items) {
    //   debugPrint(item['status'].toString());
    // }
  }

  List<Map<String, dynamic>> _applyFilter() {
    debugPrint("Widget Start Date is ${widget.startDate}");

    if (widget.startDate == null || widget.endDate == null) return items;

    DateTime start = DateFormat('dd MMM, yyyy').parse(widget.startDate!);
    DateTime end = DateFormat('dd MMM, yyyy').parse(widget.endDate!);

    print("Start Credit List is $start");

    return items.where((item) {
      DateTime itemDate = DateFormat('dd MMM, yyyy').parse(item['date']);
      return itemDate.isAtSameMomentAs(start) ||
          itemDate.isAtSameMomentAs(end) ||
          (itemDate.isAfter(start) && itemDate.isBefore(end));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Transaction list
        Expanded(child: ListViewFrame(items: filteredItems)),
      ],
    );
  }
}
