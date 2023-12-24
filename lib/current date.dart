import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scrollable CurrentDateWidget Example'),
        ),
        body: CurrentDateWidget(),
      ),
    );
  }
}

class CurrentDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12, // 12 months
      itemBuilder: (context, index) {
        DateTime firstDayOfMonth = DateTime(DateTime.now().year, index + 1, 1);
        int daysInMonth = DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day;
        int weeksInMonth = (daysInMonth + firstDayOfMonth.weekday - 1) ~/ 7 + 1;

        return MonthSection(
          month: firstDayOfMonth,
          weeksInMonth: weeksInMonth,
          daysInMonth: daysInMonth,
        );
      },
    );
  }
}

class MonthSection extends StatelessWidget {
  final DateTime month;
  final int weeksInMonth;
  final int daysInMonth;

  MonthSection({required this.month, required this.weeksInMonth, required this.daysInMonth});

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat('MMMM yyyy').format(month);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Month: $monthName',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DateSection(weeksInMonth: weeksInMonth, daysInMonth: daysInMonth),
        Divider(),
      ],
    );
  }
}

class DateSection extends StatelessWidget {
  final int weeksInMonth;
  final int daysInMonth;

  DateSection({required this.weeksInMonth, required this.daysInMonth});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 days in a week
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: weeksInMonth * 7, // Number of days in the month
      itemBuilder: (context, index) {
        if (index < daysInMonth) {
          int dayNumber = index + 1;
          DateTime currentDay = DateTime(currentDate.year, daysInMonth, dayNumber);

          bool isCurrentMonth = currentDay.month == daysInMonth;
          bool isCurrentDate = isCurrentMonth && currentDay.day == currentDate.day;

          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: isCurrentDate ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                dayNumber.toString(),
                style: TextStyle(
                  color: isCurrentDate ? Colors.white : Colors.black,
                  fontWeight: isCurrentDate ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        } else {
          return Container(); // Empty container for days beyond the current month
        }
      },
    );
  }
}
