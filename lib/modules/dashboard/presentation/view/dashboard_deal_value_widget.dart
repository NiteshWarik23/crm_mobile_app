import 'package:flutter/material.dart';

class DealValueWidget extends StatelessWidget {
  const DealValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Deal Value Text
          Text(
            'Deal Value',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.0), // Spacing
      
          // Rupee Symbol with 21.5K
          Text(
            '₹21.5K',
            style: TextStyle(
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
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(
                  text: '+18%',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
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
