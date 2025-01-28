import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_active_campaign_widget.dart';
import 'package:flutter/material.dart';

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
            Text("Progress"),
            Text("73%"),
          ],
        ),
        GradientLinearProgressIndicator(
          value: 0.73,
        ),
        Text("of leads reached out"),
      ],
    );
  }
}
