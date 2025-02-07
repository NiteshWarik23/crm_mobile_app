// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CampaignStatusWidget extends StatelessWidget {
  const CampaignStatusWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text("Status: In Progress"),
        StartAndEndDateWidget(
          startDate: "Start Date",
          dateValue: "Dec 15, 2024",
        ),
        StartAndEndDateWidget(
          startDate: "End Date",
          dateValue: "Jan 15, 2025",
        ),
      ],
    );
  }
}

class StartAndEndDateWidget extends StatelessWidget {
  String startDate;
  String dateValue;

  StartAndEndDateWidget({
    super.key,
    required this.startDate,
    required this.dateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(Icons.calendar_month),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(startDate),
            Text(dateValue),
          ],
        ),
      ],
    );
  }
}
