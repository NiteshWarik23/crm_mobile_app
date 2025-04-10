import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view_model/get_campaigns_bloc/get_campaigns_bloc.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view_model/get_campaigns_bloc/get_campaigns_event.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/view_model/get_campaigns_bloc/get_campaigns_state.dart';
import 'package:crm_mobile_app/modules/marketing/presentation/widgets/campaign_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketingScreen extends StatefulWidget {
  MarketingScreen({super.key});

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {

  @override
  void initState() {
    super.initState();
    context.read<GetCampaignsBloc>().add(OnClickOfGetCampaignsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Marketing',
          style:
              GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActiveCampaignsCard(),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: _buildCampaignsList()),
              const SizedBox(height: 20),
              _buildLeadsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCampaignsCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Campaigns',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                '+5%',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '50',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text('View Campaigns',
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCampaignsList() {
    return BlocBuilder<GetCampaignsBloc, GetCampaignsState>(
      builder: (context, state) {
        if (state is GetCampaignsEmptyState) {
          return const Center(
            child: Text("No Active Campaigns Found"),
          );
        } else if (state is GetCampaignsLoadingstate) {
          ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => const ShimmerCampaignCard(),
          );
        } else if (state is GetCampaignsSuccessstate) {
          return ListView.builder(
            itemCount: state.campaignDataList.length,
            itemBuilder: (context, index) {
              return CampaignCard(campaign: state.campaignDataList[index]);
            },
          );
        } else if (state is GetCampaignsErrorState) {
          return const Center(
            child: Text("Failed to load Campaigns"),
          );
        }
        return SizedBox.shrink();
      },
    );
    // final campaigns = [
    //   {
    //     'name': 'Facebook Ads - Christmas Sale',
    //     'amount': '\$150',
    //     'duration': '7 days'
    //   },
    //   {
    //     'name': 'Google Ads - Anna Smith',
    //     'amount': '\$500',
    //     'duration': '6 Months'
    //   },
    //   {
    //     'name': 'Instagram Promotion - Winter Sale',
    //     'amount': '\$1500',
    //     'duration': '20 Days'
    //   },
    //   {
    //     'name': 'Twitter / In App Ads',
    //     'amount': '\$450',
    //     'duration': '40 Days'
    //   },
    // ];

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const Text('Campaigns',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //     const SizedBox(height: 10),
    //     ...campaigns.map(
    //       (campaign) => Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(campaign['name']!,
    //                     style: const TextStyle(
    //                         fontSize: 16, fontWeight: FontWeight.w500)),
    //                 Text('Active • ${campaign['duration']}',
    //                     style: TextStyle(color: Colors.grey)),
    //               ],
    //             ),
    //             Text(campaign['amount']!,
    //                 style: const TextStyle(fontWeight: FontWeight.bold)),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildLeadsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Leads',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text('Channel : Instagram',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.camera_alt, color: Colors.purple, size: 20),
                ],
              ),
              const SizedBox(height: 5),
              const Text('Leads increased this month by 15%',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 5),
              const Text('+15%',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
