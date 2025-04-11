import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurvedLineGraph extends StatelessWidget {
  const CurvedLineGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the graph.  These points approximate the curve in the image.
    final List<FlSpot> chartData = [
      const FlSpot(0, 3), // Jun
      const FlSpot(1, 4),
      const FlSpot(2, 3), // July
      const FlSpot(3, 4.5),
      const FlSpot(4, 4), // Aug
      const FlSpot(5, 3),
      const FlSpot(6, 3.5), // Sep
      const FlSpot(7, 2),
      const FlSpot(8, 2.5), // Oct
      const FlSpot(9, 5),
      const FlSpot(10, 4), // Nov
      const FlSpot(11, 4.5), // Dec
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 200, // Adjust the height as needed
        child: LineChart(
          LineChartData(
            // Define the appearance of the chart.
            gridData: const FlGridData(show: false), // No grid lines
            titlesData: _buildTitleData(), // x and y axis labels.
            borderData: FlBorderData(show: false), // No border
            lineBarsData: [
              // Define the line(s) to be drawn.
              LineChartBarData(
                spots: chartData, // The data points
                isCurved: true, // Use a curved line
                barWidth: 3, // Thickness of the line
                color: Colors.green, // Color of the line
                dotData: const FlDotData(show: false), // No dots at data points
                //isStepLineChart: true,
                belowBarData: BarAreaData(
                  show: false,
                ), // No area below the line is filled.
              ),
            ],
            minX: 0, // Minimum x-value (for "Jun")
            maxX: 11, // Maximum x-value (for "Dec")
            minY: 0, // Minimum y-value
            maxY: 6, // Maximum y-value
          ),
        ),
      ),
    );
  }

  //build title data
  FlTitlesData _buildTitleData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTitlesWidget: (value, meta) {
            //map for month
            const months = {
              0: 'Jan',
              1: "Feb",
              2: 'Mar',
              3: 'Apr',
              4: 'May',
              5: 'Jun',
              6: 'Jul',
              7: 'Aug',
              8: 'Sep',
              9: 'Oct',
              10: 'Nov',
              11: 'Dec',
            };
            return Text(months[value.toInt()] ?? '',
                style: GoogleFonts.nunitoSans(
                  color: AppColors.greenshade01,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ));
          },
          //interval: 2, //show title for every 2 months
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
