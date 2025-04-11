import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_bar_graph_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/widgets/campaign_bar_graph_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/widgets/curved_line_graph_widget.dart';
import 'package:crm_mobile_app/modules/line_chart.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/campaign_progress_widget.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/campaign_status_widget.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/channel_bar_chart_view.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/channel_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewCampaignDetailedView extends StatelessWidget {
  const ViewCampaignDetailedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaigns"),
        centerTitle: true,
        actions: [
           GestureDetector(
            //TODO: Navigate to Notification screen
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset("assets/icons/notification.svg"),
            ),
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
              Text(
                "Title of the Campaign",
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
              // Container(
              //     height: MediaQuery.sizeOf(context).height * 0.5,
              //     child: SocialMediaGradientBarChart(),
              //     // LineChartExample(
              //     //   isShowingMainData: false,
              //     // ),
              //     )
            ],
          ),
        ),
      ),
    );
  }
}
