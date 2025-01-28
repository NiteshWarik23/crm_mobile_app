import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/profile/presentation/view/widgets/company_profile_widget.dart';
import 'package:crm_mobile_app/modules/profile/presentation/view/widgets/profile_header_view_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Profile"),
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
        children: [
          ProfileHeaderViewWidget(),
          CompanyProfileWidget(),
        ],
      ),
    );
  }
}
