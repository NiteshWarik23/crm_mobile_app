import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_active_campaign_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampaignProgressWidget extends StatelessWidget {
  const CampaignProgressWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progress",
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text("73%",
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        GradientLinearProgressIndicator(
          value: 0.73,
        ),
        Text(
          "of leads reached out",
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  int calculateCampaignProgressPercentage({
    required String startDate,
    required String endDate,
  }) {
    try {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      DateTime today = DateTime.now();

      // If the campaign hasn't started yet
      if (today.isBefore(start)) return 0;

      // If the campaign is already ended
      if (today.isAfter(end)) return 100;

      int totalDuration = end.difference(start).inDays;
      int daysCompleted = today.difference(start).inDays;

      // Avoid division by zero
      if (totalDuration == 0) return 100;

      double percentage = (daysCompleted / totalDuration) * 100;

      return percentage.clamp(0, 100).toInt();
    } catch (e) {
      // Handle invalid date formats or errors
      print('Error calculating campaign progress: $e');
      return 0;
    }
  }
}
