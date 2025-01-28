import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_bar_graph_widget.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_progress_widget.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_status_widget.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/channel_bar_chart_view.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/channel_performance_widget.dart';
import 'package:flutter/material.dart';

class ViewCampaignDetailedView extends StatelessWidget {
  const ViewCampaignDetailedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaigns"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Badge(
              //count: 50,
              label: Text(
                '🟢',
                style: TextStyle(fontSize: 8, color: AppColors.greenshade01),
              ),
              child: const Icon(Icons.notifications_none_outlined),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
            left: 15.0,
            bottom: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Text("Title of the Campaign"),
              Center(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/image.png"),
                  ),
                ),
              ),
              CampaignProgressWidget(),
              CampaignStatusWidget(),
              ChannelPerformanceWidget(),
               Center(child: BarChartSample4()),
            ],
          ),
        ),
      ),
    );
  }
}
