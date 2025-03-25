import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_active_campaign_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_channel_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_deal_value_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_lead_view.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_tabs_widget.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_todays_follow_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<double> salesData = [5, 8, 6, 10, 12, 4, 2, 16, 22, 8, 15, 35];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Text(
              'Welcome Back',
              style: GoogleFonts.nunitoSans(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SvgPicture.asset("assets/icons/welcome.svg"),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            //TODO: Navigate to Notification screen
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset("assets/icons/notification.svg"),
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: 
                  //SvgPicture.asset("assets/icons/userprofile.svg")
                  CircleAvatar(
                    maxRadius: 30.0 ,
                    backgroundImage: AssetImage("assets/images/image.png"),
                  ),
                ),
                TotalBalance(),
              ],
            ),
          ),
          RoundedTabBar(
            tabController: _tabController,
          ),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    DealValueWidget(),
                    TabBarViewBody(
                      tabController: _tabController,
                      salesData: salesData,
                    ),
                    LeadViewWidget(),
                    TodaysFollowUpWidget(),
                    PieChartSample2(),
                    ActiveCampaignWidget(),
                    //ChannelStatsFlChart(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class TotalBalance extends StatelessWidget {
  const TotalBalance({
    super.key,
  });

  double get balance => 580360.580;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          '\$ ${balance.toStringAsFixed(3)}',
          style: GoogleFonts.nunitoSans(
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        RichText(
          text: TextSpan(
            text: '+2.5% ',
            style: GoogleFonts.nunitoSans(fontSize: 17,fontWeight: FontWeight.w500,color: AppColors.greenshade01),
            children: [
              TextSpan(
                text: 'This Month',
                style: GoogleFonts.nunitoSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,

                    ),
                
              ),
            ],
          ),
        ),
        Text(
          'Total Balance',
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
