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
      'date': '14 Aug, 2025 12:45',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Travel & Tour',
      'status': 'decrease',
      'point': 124,
      'date': '13 Aug, 2025 16:23',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 1',
      'status': 'increase',
      'point': 70,
      'date': '11 Aug, 2025 09:16',
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
      'date': '10 Aug, 2025 18:20',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Food',
      'status': 'decrease',
      'point': 100,
      'date': '8 Aug, 2025 22:32',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Drink',
      'status': 'decrease',
      'point': 124,
      'date': '5 Aug, 2025 10:19',
    },
    // Randomly generated items
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 2',
      'status': 'increase',
      'point': 85,
      'date': '4 Aug, 2025 08:30',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Alice Smith',
      'status': 'increase',
      'point': 210,
      'date': '3 Aug, 2025 14:50',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Books',
      'status': 'decrease',
      'point': 50,
      'date': '2 Aug, 2025 17:12',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer Out',
      'from_name': 'Bob Lee',
      'status': 'decrease',
      'point': 300,
      'date': '1 Aug, 2025 19:40',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 3',
      'status': 'increase',
      'point': 60,
      'date': '31 Jul, 2025 07:50',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Cafe',
      'status': 'decrease',
      'point': 90,
      'date': '30 Jul, 2025 10:30',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Charlie Kim',
      'status': 'increase',
      'point': 420,
      'date': '29 Jul, 2025 12:15',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Grocery',
      'status': 'decrease',
      'point': 75,
      'date': '28 Jul, 2025 15:00',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 4',
      'status': 'increase',
      'point': 95,
      'date': '27 Jul, 2025 09:05',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer Out',
      'from_name': 'Diana Ray',
      'status': 'decrease',
      'point': 180,
      'date': '26 Jul, 2025 18:45',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Clothes',
      'status': 'decrease',
      'point': 130,
      'date': '25 Jul, 2025 20:10',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Ethan White',
      'status': 'increase',
      'point': 250,
      'date': '24 Jul, 2025 11:25',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 5',
      'status': 'increase',
      'point': 110,
      'date': '23 Jul, 2025 08:40',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Movie Tickets',
      'status': 'decrease',
      'point': 60,
      'date': '22 Jul, 2025 19:30',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer Out',
      'from_name': 'Frank Lee',
      'status': 'decrease',
      'point': 220,
      'date': '21 Jul, 2025 17:45',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 6',
      'status': 'increase',
      'point': 80,
      'date': '20 Jul, 2025 07:55',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Cafe',
      'status': 'decrease',
      'point': 95,
      'date': '19 Jul, 2025 12:30',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Grace Park',
      'status': 'increase',
      'point': 310,
      'date': '18 Jul, 2025 14:10',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Books',
      'status': 'decrease',
      'point': 55,
      'date': '17 Jul, 2025 16:50',
    },
    {
      'icon': AppIcons.busSvgIcon(color: AppColors.listIconColor, size: 30),
      'title': 'Transport',
      'from_name': 'Route- 7',
      'status': 'increase',
      'point': 105,
      'date': '16 Jul, 2025 09:20',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer Out',
      'from_name': 'Hannah Kim',
      'status': 'decrease',
      'point': 195,
      'date': '15 Jul, 2025 18:00',
    },
    {
      'icon': AppIcons.exchangeSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Redeem',
      'from_name': 'Food',
      'status': 'decrease',
      'point': 85,
      'date': '14 Jul, 2025 20:20',
    },
    {
      'icon': AppIcons.transitionSvgIcon(
        color: AppColors.listIconColor,
        size: 25,
      ),
      'title': 'Transfer In',
      'from_name': 'Ian Brown',
      'status': 'increase',
      'point': 400,
      'date': '13 Jul, 2025 11:15',
    },
  ];

  late List<Map<String, dynamic>> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = _applyFilter();

    // for (var fil in filteredItems) {
    //   debugPrint(fil['status'].toString());
    // }

    // for (var item in items) {
    //   debugPrint(item['status'].toString());
    // }
  }

  List<Map<String, dynamic>> _applyFilter() {
    // debugPrint("Widget Start Date is ${widget.startDate}");

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
