import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SocialMediaGradientBarChart extends StatelessWidget {
   SocialMediaGradientBarChart({super.key});
  final String currentMonth = DateFormat.MMM().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Sample data for the bar chart
    final List<BarChartGroupData> barChartData = [
      _makeGroupData(0, 75), // Instagram
      _makeGroupData(1, 64), // Facebook
      _makeGroupData(2, 82), // WhatsApp
      _makeGroupData(3, 45), // LinkedIn
      _makeGroupData(4, 77), // Snapchat
      _makeGroupData(5, 16), // Twitter
      _makeGroupData(6, 75), // Pinterest
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 300, // Adjust the height as needed
        child: BarChart(
          BarChartData(
            // Define the appearance of the chart
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.toY.round().toString(),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            gridData: const FlGridData(show: false), // No grid lines
            titlesData: _buildTitleData(context), // x and y axis labels
            borderData: FlBorderData(show: false), // No border
            barGroups: barChartData, // The list of bar groups
            maxY: 100, // Maximum y-value for the chart
          ),
        ),
      ),
    );
  }

  // Function to create BarChartGroupData for each bar
  static BarChartGroupData _makeGroupData(int x, int y) {
    return BarChartGroupData(
      x: x, // x-value (position on the horizontal axis)
      barRods: [
        BarChartRodData(
          toY: y.toDouble(), // y-value (height of the bar)
          // Implement gradient color
          gradient: const LinearGradient(
            colors: [
              Color(0xFF219653),
              Color(0xFFB2FAB4), // Light green at the top
              Color(0xffffffff), // Darker green at the bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(),
          width: 30,
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0,
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: false,
          ),
        ),
      ],
    );
  }

  // Function to build title data
  FlTitlesData _buildTitleData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 80,
          getTitlesWidget: (value, meta) {
            // Map for social media icons
            const socialMediaIcons = {
              0: 'assets/icons/instagreen.svg', // Replace with your SVG asset paths
              1: 'assets/icons/instagreen.svg',
              2: 'assets/icons/instagreen.svg',
              3: 'assets/icons/instagreen.svg',
              4: 'assets/icons/instagreen.svg',
              5: 'assets/icons/instagreen.svg',
              6: 'assets/icons/instagreen.svg',
            };
            //map for social media
            //  socialMediaLabels = {
            //   0: currentMonth,
            //   1: 'fb',
            //   2: 'WApp',
            //   3: 'in',
            //   4: 'Snap',
            //   5: 'Twit',
            //   6: 'Pin',
            // };
            // return Text(
            //   socialMediaLabels[value.toInt()] ?? '',
            //   style: const TextStyle(
            //     color: Color(0xff68737d),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14,
            //   ),
            // );
            //show month labels
            return SideTitleWidget(
              meta: meta,
              child: Column(
                spacing: 5.0,
                //mainAxisSize: MainAxisSize.min, // Use min to avoid extra space
                children: [
                  SvgPicture.asset(
                    socialMediaIcons[value.toInt()] ??
                        '', // Use SvgPicture to display the icon
                    width: 20, // Adjust size as needed
                    height: 20,
                  ),
                  //const SizedBox(height: 7), // Add some spacing
                  Text(
                   currentMonth,
                    style: const TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false), // No labels on the left axis
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }
}
