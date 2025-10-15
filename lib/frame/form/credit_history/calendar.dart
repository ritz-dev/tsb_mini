import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsb_mini/theme/responsive.dart';

class Calendar extends StatefulWidget {
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  const Calendar({
    super.key,
    required this.startDateController,
    required this.endDateController,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now);
    final datePart = DateFormat('dd MMM, yyyy').format(now);

    if (widget.startDateController.text.isEmpty) {
      widget.startDateController.text = "$dayName\n$datePart";
    }
    if (widget.endDateController.text.isEmpty) {
      widget.endDateController.text = "$dayName\n$datePart";
    }
  }

  DateTime? _parseControllerDate(String text) {
    if (text.isEmpty) return null;
    var s = text;
    if (s.contains('\n')) s = s.split('\n').last;
    try {
      return DateFormat('d MMM, yyyy').parse(s);
    } catch (_) {
      return null;
    }
  }

  Future<void> _pickStartDate() async {
    final end = _parseControllerDate(widget.endDateController.text);

    // set lastDate to end (if available) to prevent selecting a start after the end
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _parseControllerDate(widget.startDateController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: end ?? DateTime(2100),
    );

    if (pickedDate != null) {
      // If end exists and picked start is after end, show message and don't accept
      if (end != null && pickedDate.isAfter(end)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Start date cannot be after the selected end date')),
        );
        return;
      }

      final dayName = DateFormat('EEEE').format(pickedDate);
      final datePart = DateFormat('dd MMM, yyyy').format(pickedDate);

      setState(() {
        widget.startDateController.text = "$dayName\n$datePart";
      });
    }
  }

  Future<void> _pickEndDate() async {
    final start = _parseControllerDate(widget.startDateController.text);

    // set firstDate to start (if available) to prevent selecting an end before the start
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _parseControllerDate(widget.endDateController.text) ?? DateTime.now(),
      firstDate: start ?? DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // If start exists and picked end is before start, show message and don't accept
      if (start != null && pickedDate.isBefore(start)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End date cannot be before the selected start date')),
        );
        return;
      }

      final dayName = DateFormat('EEEE').format(pickedDate);
      final datePart = DateFormat('dd MMM, yyyy').format(pickedDate);

      setState(() {
        widget.endDateController.text = "$dayName\n$datePart";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _dateBuilder(widget.startDateController, _pickStartDate),
        _dateBuilder(widget.endDateController, _pickEndDate),
      ],
    );
  }

  Widget _dateBuilder(TextEditingController controller, VoidCallback pickDate) {
    final responsive = Responsive(context);
    // Split day and date for styling
    final parts = controller.text.split('\n');
    final dayName = parts.length > 1 ? parts[0] : '';
    final datePart = parts.length > 1 ? parts[1] : controller.text;

    return Container(
      width: responsive.isMobile
          ? responsive.width * 0.42
          : responsive.width * 0.37,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // subtle off-white
        borderRadius: BorderRadius.circular(43),
        border: Border.all(
          color: Color(0xFF959595).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(43),
        onTap: pickDate,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 20, color: Color(0xFF959595)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: const TextStyle(
                        color: Color(0xFF323236),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      datePart,
                      style: const TextStyle(
                        color: Color(0xFF323236),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
