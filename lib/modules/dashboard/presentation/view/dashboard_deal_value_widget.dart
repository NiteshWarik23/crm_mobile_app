import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DealValueWidget extends StatelessWidget {
  const DealValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Deal Value Text
          Text(
            'Deal Value',
            style: GoogleFonts.inter(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.0), // Spacing

          // Rupee Symbol with 21.5K
          Text(
            '₹21.5K',
            style: GoogleFonts.inter(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.0), // Spacing

          // Rich Text: Monthly in black and +18% in green
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Monthly ',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '+18%',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greenshade01,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
