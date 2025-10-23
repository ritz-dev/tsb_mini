import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/frame/body/credit_transfer/transfer_list_view_frame.dart';
import 'package:tsb_mini/frame/body/history/list_view_frame.dart';
import 'package:tsb_mini/theme/color_theme.dart';
import 'package:tsb_mini/theme/icon_theme.dart';

class RecentTransfer extends StatefulWidget {
  final String? startDate;
  final String? endDate;
  final Function (String id)? onTapItem;

  const RecentTransfer ({super.key, this.startDate, this.endDate , this.onTapItem});

  @override
  State<RecentTransfer> createState() => _RecentTransferState();
}

class _RecentTransferState extends State<RecentTransfer> {
  List<Map<String, dynamic>> items = [
    {
      'icon': HeroIcon(HeroIcons.user, color: Color(0XFFFFFFFF), size: 25),
      'from_name': 'Mr. John Doe',
      'id': '10000001111',
      'status': 'increase',
      'point': 380,
      'date': '14 Aug, 2025',
    },
    {
      'icon': HeroIcon(HeroIcons.user, color: Color(0XFFFFFFFF), size: 25),
      'from_name': 'Ms. Jane Smith',
      'id': '10000001112',
      'status': 'increase',
      'point': 450,
      'date': '13 Aug, 2025',
    },
    {
      'icon': HeroIcon(HeroIcons.user, color: Color(0XFFFFFFFF), size: 25),
      'from_name': 'Mr. Alex Brown',
      'id': '10000001113',
      'status': 'increase',
      'point': 220,
      'date': '12 Aug, 2025',
    },
    {
      'icon': HeroIcon(HeroIcons.user, color: Color(0XFFFFFFFF), size: 25),
      'from_name': 'Ms. Emily Clark',
      'id': '10000001114',
      'status': 'increase',
      'point': 150,
      'date': '11 Aug, 2025',
    },
    {
      'icon': HeroIcon(HeroIcons.user, color: Color(0XFFFFFFFF), size: 25),
      'from_name': 'Mr. Michael Lee',
      'id': '10000001115',
      'status': 'increase',
      'point': 500,
      'date': '10 Aug, 2025',
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
  return TransferListViewFrame(
      items: filteredItems,
      shrinkWrap: true, // important!
      physics: NeverScrollableScrollPhysics(),
      onTapItem: (Map<String, dynamic> item) {
        if (widget.onTapItem != null) {
          widget.onTapItem!(item['id']); // pass ID to parent
        }
      }, // prevent inner scrolling
    );

  }
}
