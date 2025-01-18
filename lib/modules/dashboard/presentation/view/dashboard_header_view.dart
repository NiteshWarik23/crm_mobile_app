import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_tabs_widget.dart';
import 'package:crm_mobile_app/modules/splash/graph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Back 👋',
          style:
              GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.w700),
        ),
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
                  child: CircleAvatar(),
                ),
                TotalBalance(),
              ],
            ),
          ),
          RoundedTabBar(),
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
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.greenshade01,
            ),
            children: [
              TextSpan(
                text: 'This Month',
                style: TextStyle(
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
