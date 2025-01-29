import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_header_view.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_event.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_state.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view/campaign_detailed_view/view_campaign_detailed_view.dart';
import 'package:crm_mobile_app/modules/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _screens = [
    DashboardHeader(),
    SearchPage(),
    ViewCampaignDetailedView(),
    AlertsPage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          if (state is BottomNavInitial) {
            return _screens[state.index];
          } else if (state is BottomNavUpdatedState) {
            return _screens[state.index];
          }
          return _screens[0];
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          bottom: 25.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            iconSize: 10,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: AppColors.greenshade01,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex:
                (context.watch<BottomNavBloc>().state is BottomNavUpdatedState)
                    ? (context.watch<BottomNavBloc>().state
                            as BottomNavUpdatedState)
                        .index
                    : 0,
            onTap: (index) {
              context.read<BottomNavBloc>().add(UpdateIndex(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/dashboard.png',
                  width: 18,
                  height: 18,
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/crm.png',
                  width: 20,
                  height: 20,
                ),
                label: 'CRM',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/marketing.png',
                  width: 20,
                  height: 20,
                ),
                label: 'Marketing',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/chats.png',
                  width: 20,
                  height: 20,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile.png',
                  width: 20,
                  height: 20,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: DashboardHeader(),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Search Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Add Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Alerts Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}


