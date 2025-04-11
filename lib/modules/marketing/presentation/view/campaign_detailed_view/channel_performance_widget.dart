import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelPerformanceWidget extends StatelessWidget {
  const ChannelPerformanceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          "Channel Performance",
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "CTR",
          style: GoogleFonts.nunitoSans(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "1.56%",
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Last 30 Days ',
                style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              TextSpan(
                text: '+12%',
                style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greenshade01,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
