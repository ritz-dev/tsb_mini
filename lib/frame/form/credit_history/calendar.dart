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
  // final TextEditingController _startDateController = TextEditingController();

  // final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.startDateController.text.isEmpty) {
      widget.startDateController.text = "Monday\n11 Aug, 2025";
    }
    if (widget.endDateController.text.isEmpty) {
      widget.endDateController.text = "Wednesday\n20 Aug, 2025";
    }
  }

  Future<void> _pickStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime(2100), // Latest date
    );

    if (pickedDate != null) {
      String dayName = DateFormat('EEEE').format(pickedDate);

      String datePart = DateFormat('dd MMM, yyyy').format(pickedDate);

      setState(() {
        widget.startDateController.text = "$dayName\n$datePart";
      });
    }
  }

  Future<void> _pickEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime(2100), // Latest date
    );

    if (pickedDate != null) {
      String dayName = DateFormat('EEEE').format(pickedDate);

      String datePart = DateFormat('dd MMM, yyyy').format(pickedDate);

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
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA), // subtle off-white
        borderRadius: BorderRadius.circular(43),
        border: Border.all(
          color: Color(0xFF83848B).withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
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
              Icon(Icons.calendar_today, size: 20, color: Color(0xFF959595)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(
                        color: Color(0xFF323236),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      datePart,
                      style: TextStyle(
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
