// import 'package:crm_mobile_app/core/utils/app_colors.dart';
// import 'package:crm_mobile_app/modules/crm/lead/presentation/view/lead_card.dart';
// import 'package:crm_mobile_app/modules/crm/lead/presentation/view/lead_list_screen.dart';
// import 'package:crm_mobile_app/modules/crm/lead/presentation/view/leads_screen.dart';
// import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_bar_graph_widget.dart';
// import 'package:crm_mobile_app/modules/crm/lead/presentation/view/calender_screen.dart';
// import 'package:crm_mobile_app/modules/splash/graph.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CrmRoundedTabBar extends StatefulWidget {
//   const CrmRoundedTabBar({
//     super.key,
//     required TabController tabController,
//   }) : _tabController = tabController;

//   final TabController _tabController;

//   @override
//   State<CrmRoundedTabBar> createState() => _CrmRoundedTabBarState();
// }

// class _CrmRoundedTabBarState extends State<CrmRoundedTabBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(left: 10, right: 10),
//           height: MediaQuery.sizeOf(context).height * 0.05,
//           padding: EdgeInsets.symmetric(
//             vertical: 2,
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 1),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: TabBar(
//             tabAlignment: TabAlignment.fill,
//             dividerColor: Colors.transparent,
//             controller: widget._tabController,
//             indicator: BoxDecoration(
//               color: AppColors.greenshade01,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             indicatorPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
//             labelPadding: EdgeInsets.symmetric(horizontal: 5),
//             labelColor: Colors.white,
//             unselectedLabelColor: Theme.of(context).colorScheme.primary,
//             //isScrollable: true,
//             indicatorSize: TabBarIndicatorSize.tab,
//             tabs: [
//               Tab(text: "Leads"),
//               Tab(text: "Deals"),
//               Tab(text: "Calendar"),
//             ],
//           ),
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }

// class TabBarViewBody extends StatelessWidget {
//   TabBarViewBody({
//     super.key,
//     required TabController tabController,
//   }) : _tabController = tabController;

//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       //height: 300, // Adjust height as needed
//       child: TabBarView(
//         controller: _tabController,
//         children: [
//           Center(
//             child: 
//             // Expanded(
//             //   child: 
//               LeadsListScreen(),
//            // ),
//           ),
//           Center(child: LeadsListScreen()),
//           Center(child: AppointmentScreen()),
//         ],
//       ),
//     );
//   }
// }
