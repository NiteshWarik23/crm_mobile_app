// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm_mobile_app/core/utils/call_service.dart';
import 'package:crm_mobile_app/core/utils/email_service.dart';
import 'package:crm_mobile_app/core/utils/sms_service.dart';
import 'package:crm_mobile_app/modules/crm/presentation/widgets/dropdown_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadDetailsScreen extends StatelessWidget {
  final String? leadName;
  final String? leadEmailId;
  final String? leadContact;
  final String? leadStatus;
  final String? leadChannel;
  final String? leadID;

  const LeadDetailsScreen(
      {super.key,
      this.leadName,
      this.leadEmailId,
      this.leadContact,
      this.leadStatus,
      this.leadChannel,
      this.leadID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                _buildIconButton(Icons.call, () {
                  CallService.makePhoneCall(leadContact ?? "");
                }),
                _buildIconButton(Icons.sms, () {
                  SmsService.sendSms(leadContact ?? "",
                      message: "Hello $leadName");
                }),
                _buildIconButton(Icons.mail_lock_outlined, () {}),
                _buildIconButton(Icons.mail, () {
                  MailService.sendEmail(
                    email: "$leadEmailId",
                    subject: "Hello",
                    body: "This is a test email",
                  );
                }),
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
    );
  }

  Widget taskSectionWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Task',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        //const SizedBox(height: 10),
        _buildTaskButton(Icons.note_add, 'Add Note', Icons.add),
        //const SizedBox(height: 10),
        _buildTaskButton(Icons.update, 'Update Status', Icons.add,
            onPressed: () {
          print("-->Lead Details Lead CRM ID ${leadID}");

          showDropdownBottomSheet(context, leadID ?? "");
        }),
      ],
    );
  }

  Widget campaignDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Campaign Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        const Text(
          'Contact Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Email',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              leadEmailId ?? "NA",
              style: TextStyle(fontSize: 16, color: Colors.black),
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
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              leadContact ?? "NA",
              style: TextStyle(fontSize: 16, color: Colors.black),
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
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

  Widget _buildIconButton(IconData icon, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber[100],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.black, size: 23),
      ),
    );
  }

  Widget _buildTaskButton(IconData icon, String label, IconData icon2,
      {GestureTapCallback? onPressed}) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 10),
        Text(label),
        Spacer(),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            //padding: const EdgeInsets.all(6.0),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white, // Button background color
              shape: BoxShape.circle, // Makes it circular
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  // Shadow color
                  spreadRadius: 0.5,
                  // Reduce spread for a smaller shadow
                  blurRadius: 5,
                  // Soften the shadow
                  offset: const Offset(0, 2), // Subtle vertical shadow
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon2,
                color: Colors.grey,
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
