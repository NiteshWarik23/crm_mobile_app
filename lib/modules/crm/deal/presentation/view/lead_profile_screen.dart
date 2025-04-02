// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/core/utils/call_service.dart';
import 'package:crm_mobile_app/core/utils/email_service.dart';
import 'package:crm_mobile_app/core/utils/sms_service.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/create_note_widget.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/create_tag_widget.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/dropdown_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadDetailsScreen extends StatelessWidget {
  final String? leadName;
  final String? leadEmailId;
  final String? leadContact;
  final String? leadStatus;
  final String? leadChannel;
  final String? leadID;

  LeadDetailsScreen(
      {super.key,
      this.leadName,
      this.leadEmailId,
      this.leadContact,
      this.leadStatus,
      this.leadChannel,
      this.leadID});

  final LeadBloc leadBloc = locator<LeadBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => leadBloc,
      child: BlocListener<LeadBloc, LeadState>(
        listener: (BuildContext context, LeadState state) {
          print("Listening");
          if (state.updateLeadStatus ==
              UpdateLeadStatus.updateLeadStatusLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Updating Lead Status...Please Wait"),
              ),
            );
            //Navigator.pop(context);
          } else if (state.updateLeadStatus ==
              UpdateLeadStatus.updateLeadStatusSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Lead Status Updated"),
              ),
            );
            Navigator.pop(context);
          } else if (state.updateLeadStatus ==
              UpdateLeadStatus.updateLeadStatusFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to update Lead Status"),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: appBarWidget(context),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                leadImageAndNameWidget(),
                const SizedBox(height: 10),
                contactInformationWidget(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconButton(
                        Colors.amber[100]!, "assets/icons/call.svg", () {
                      CallService.makePhoneCall(leadContact ?? "");
                    }),
                    _buildIconButton(
                        Colors.amber[100]!, "assets/icons/messageSms.svg", () {
                      SmsService.sendSms(leadContact ?? "",
                          message: "Hello $leadName");
                    }),
                    _buildIconButton(
                        Colors.amber[100]!, "assets/icons/whatsapp.svg", () {}),
                    _buildIconButton(
                      Colors.amber[100]!,
                      "assets/icons/email.svg",
                      () {
                        MailService.sendEmail(
                          email: "$leadEmailId",
                          subject: "Hello",
                          body: "This is a test email",
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                campaignDetailsWidget(),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                taskSectionWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskSectionWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Task',
          style:
              GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        _buildTaskButton("assets/icons/note.svg", 'Add Note', Icons.add,
            onPressed: () {
          showCreateNoteBottomSheet(context, leadID ?? "");
        }),
        _buildTaskButton(
            "assets/icons/updateStatus.svg", 'Update Status', Icons.add,
            onPressed: () {
          showDropdownBottomSheet(context, leadID ?? "");
        }),
        _buildTaskButton("assets/icons/addTag.svg", 'Add Tag', Icons.add,
            onPressed: () {
          showCreateTagBottomSheet(context, leadID ?? "");
        }),
        _buildTaskButton(
            "assets/icons/followUp.svg", 'Schedule Follow Up', Icons.add,
            onPressed: () {
          showDropdownBottomSheet(context, leadID ?? "");
        }),
      ],
    );
  }

  Widget campaignDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Campaign Details',
            style: GoogleFonts.nunitoSans(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _InfoRow(label: 'Campaign Name', value: 'Name Of Campaign'),
        ),
        Divider(
          color: Colors.grey[200],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _InfoRow(label: 'Channel', value: 'Instagram / Facebook'),
        ),
        Divider(
          color: Colors.grey[200],
        ),
      ],
    );
  }

  Widget contactInformationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style:
              GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Email',
              style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              leadEmailId ?? "NA",
              style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Number',
              style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              leadContact ?? "NA",
              style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget leadImageAndNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100, // Diameter of CircleAvatar
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: getStatusColor(leadStatus ?? ""), // Border color
              width: 3.0, // Border width
            ),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 30, color: Colors.grey[200]),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          leadName?.toUpperCase() ?? "NA",
          style:
              GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Divider(
          color: Colors.grey[200],
        ),
      ],
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Lead Profile",
        style: GoogleFonts.nunitoSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
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
      centerTitle: true,
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.grey.shade600;
      case 'contacted':
        return Colors.orange;
      case 'nurture':
        return Colors.blue.shade600;
      case 'qualified':
        return Colors.green;
      case 'unqualified':
        return Colors.red;
      case 'junk':
        return Colors.deepPurple;
      default:
        return Colors.grey.shade800;
    }
  }

  Widget _buildIconButton(
      //IconData icon,
      Color color,
      String svgAssetString,
      GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(svgAssetString)
          //Icon(icon, color: Colors.black, size: 23),
          ),
    );
  }

  Widget _buildTaskButton(
      //IconData icon,
      String svgAssetString,
      String label,
      IconData icon2,
      {GestureTapCallback? onPressed}) {
    return Row(
      children: [
        //Icon(icon, color: Colors.black54),
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyshade500)),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(svgAssetString)
            //Icon(icon, color: Colors.black, size: 23),
            ),
        const SizedBox(width: 10),
        Text(label),
        Spacer(),
        label == "Add Note"
            ? Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white, // Button background color
                        shape: BoxShape.circle, // Makes it circular
                        border: Border.all(color: AppColors.greyshade500)),
                    child: Center(
                      child: Icon(
                        Icons.view_list,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            //padding: const EdgeInsets.all(6.0),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, // Button background color
                shape: BoxShape.circle, // Makes it circular
                border: Border.all(color: AppColors.greyshade500)),
            child: Center(
              child: Icon(
                icon2,
                color: Colors.grey,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth *
                0.4, // Fixed width for the label to ensure alignment
            child: Text(
              label,
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
