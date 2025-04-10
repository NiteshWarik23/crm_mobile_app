import 'package:crm_mobile_app/modules/marketing/data/services/models/response/get_campaigns_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampaignCard extends StatelessWidget {
  final CampaignData campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.name ?? 'NA',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatDate(campaign.creation ?? "NA"),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Text(
              campaign.campaignStatus ?? 'NA',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }


String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

  // Get current date without time
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime receivedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  int daysAgo = today.difference(receivedDate).inDays;

  return "Active • $daysAgo day${daysAgo == 1 ? '' : 's'}";
}

}




class ShimmerCampaignCard extends StatefulWidget {
  const ShimmerCampaignCard({super.key});

  @override
  State<ShimmerCampaignCard> createState() => _ShimmerCampaignCardState();
}

class _ShimmerCampaignCardState extends State<ShimmerCampaignCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return _buildShimmerCard(_shimmerController.value);
      },
    );
  }

  Widget _buildShimmerCard(double shimmerValue) {
    final gradient = LinearGradient(
      colors: [
        Colors.grey.shade300,
        Colors.grey.shade100,
        Colors.grey.shade300,
      ],
      stops: const [0.1, 0.3, 0.4],
      begin: Alignment(-1.0 - shimmerValue * 2, 0.0),
      end: Alignment(1.0 + shimmerValue * 2, 0.0),
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ShaderMask(
        shaderCallback: (bounds) => gradient.createShader(bounds),
        blendMode: BlendMode.srcATop,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column (title and subtitle)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(width: 120, height: 16),
                  const SizedBox(height: 8),
                  shimmerBox(width: 100, height: 12),
                ],
              ),
              // Right side (status)
              shimmerBox(width: 60, height: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerBox({double width = 100, double height = 16}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
