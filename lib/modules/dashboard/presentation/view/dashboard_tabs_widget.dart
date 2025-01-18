import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/splash/graph.dart';
import 'package:flutter/material.dart';

class RoundedTabBar extends StatefulWidget {
  const RoundedTabBar({super.key});

  @override
  State<RoundedTabBar> createState() => _RoundedTabBarState();
}

class _RoundedTabBarState extends State<RoundedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<double> salesData = [5, 8, 6, 10, 12, 4, 2, 16, 22, 8, 15, 35];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: MediaQuery.sizeOf(context).height * 0.05,
          padding: EdgeInsets.symmetric(vertical: 2,),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppColors.greenshade01,
              borderRadius: BorderRadius.circular(30),
            ),
            indicatorPadding: EdgeInsets.symmetric(vertical: 2),
            labelPadding: EdgeInsets.symmetric(horizontal: 50),
            labelColor: Colors.white,
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Search"),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 300, // Adjust height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: SalesChartCustom(monthlySales: salesData)),
              Center(child: SalesChartCustom(monthlySales: salesData)),
            ],
          ),
        ),
      ],
    );
  }
}
