// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampaignStatusWidget extends StatelessWidget {
  const CampaignStatusWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          "Status: In Progress",
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.greyshade500,
          ),
        ),
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
            Text(
              startDate,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              dateValue,
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.greyshade500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
