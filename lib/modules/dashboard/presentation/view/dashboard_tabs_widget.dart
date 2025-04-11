import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_bar_graph_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/widgets/campaign_bar_graph_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/widgets/curved_line_graph_widget.dart';
import 'package:crm_mobile_app/modules/splash/graph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedTabBar extends StatefulWidget {
  const RoundedTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<RoundedTabBar> createState() => _RoundedTabBarState();
}

class _RoundedTabBarState extends State<RoundedTabBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: MediaQuery.sizeOf(context).height * 0.05,
          padding: EdgeInsets.symmetric(
            vertical: 2,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TabBar(
            tabAlignment: TabAlignment.fill,
            dividerColor: Colors.transparent,
            controller: widget._tabController,
            indicator: BoxDecoration(
              color: AppColors.greenshade01,
              borderRadius: BorderRadius.circular(30),
            ),
            indicatorPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            labelPadding: EdgeInsets.symmetric(horizontal: 45),
            labelColor: Colors.white,
            labelStyle:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
            unselectedLabelColor:
                AppColors.greenshade01, //Theme.of(context).colorScheme.primary,
            //isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Leads"),
              Tab(text: "Campaign"),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class TabBarViewBody extends StatelessWidget {
  const TabBarViewBody({
    super.key,
    required TabController tabController,
    required this.salesData,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<double> salesData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Adjust height as needed
      child: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: CurvedLineGraph()
            //SalesChartCustom(monthlySales: salesData),
          ),
          Center(child: 
          SocialMediaGradientBarChart()
          //CampaignBarChart()
          ),
        ],
      ),
    );
  }
}
