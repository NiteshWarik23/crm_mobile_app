import 'package:crm_mobile_app/config/routes/arguments/lead_details_arguments.dart';
import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/lead_response.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/search_lead_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum Menu { delete, convertToDeal }

class LeadCard extends StatelessWidget {
  final LeadData leadData;

  LeadCard({super.key,required this.leadData,});

  @override
  Widget build(BuildContext context) {
    final leadBloc = context.read<LeadBloc>();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {

        Navigator.pushNamed(
          context,
          AppRoutes.leadProfileScreen,
          arguments: LeadDetailsArguments(
            leadName: leadData.firstName,
            leadEmailId: leadData.email,
            leadContact: leadData.mobileNo,
            leadStatus: leadData.status,
            leadChannel: leadData.facebookCampaign,
            leadID: leadData.name,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 18.0),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns children to the top
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.person, size: 30, color: Colors.grey),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // )
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown, // Scales the text down to fit
                          child: Text(
                            leadData.firstName ?? "NA",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown, // Scales the text down to fit
                          child: Text(
                            "Email : ${leadData.email ?? "NA"}",
                            maxLines: 1, // Restrict to a single line
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown, // Scales the text down to fit
                          child: Text(
                            "Contact : ${leadData.mobileNo ?? "NA"}",
                            maxLines: 1, // Restrict to a single line
                            style: GoogleFonts.nunitoSans(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown, // Scales the text down to fit
                          child: Text(
                            "Campaign Name",
                            maxLines: 1, // Restrict to a single line
                            style: GoogleFonts.nunitoSans(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  PopupMenuButton<Menu>(
                    //popUpAnimationStyle: _animationStyle,
                    icon: const Icon(Icons.more_vert),
                    onSelected: (Menu item) {
                      if (item == Menu.delete) {
                        leadBloc
                            .add(DeleteLeadEvent(leadID: leadData.name ?? ""));
                      } else if (item == Menu.convertToDeal) {
                        leadBloc.add(ConvertLeadToDealEvent(
                            leadID: leadData.name ?? ""));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Menu>>[
                      PopupMenuItem<Menu>(
                        value: Menu.delete,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(Icons.delete),
                          title: Text(
                            'Delete',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem<Menu>(
                        value: Menu.convertToDeal,
                        child: ListTile(
                          leading: Icon(Icons.replay),
                          title: Text(
                            'Convert To Deal',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Lead status
                  // Container(
                  //   width: screenWidth * 0.2, // Fixed width
                  //   height: screenHeight * 0.03, // Fixed height
                  //   decoration: BoxDecoration(
                  //     color: getStatusColor(
                  //         leadData.status ?? ""), //user.statusColor,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   alignment:
                  //       Alignment.center, // Center the text within the container
                  //   child: Text(
                  //     leadData.status ?? "",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     overflow: TextOverflow
                  //         .ellipsis, // Truncate the text if it's too long
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        formatDate(leadData.creation ?? "NA"),
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12, color: Colors.black),
                      ),
                      leadData.metaPlatform != null
                          ? leadData.metaPlatform == "ig"
                              ? SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: Image.asset("assets/icons/insta.png"),
                                )
                              : SizedBox()
                          : SizedBox(),
                    ],
                  ),
                  // Add a SizedBox with height to make the VerticalDivider visible
                  SizedBox(
                    height:
                        screenHeight * 0.02, // Set height to match the content
                    child: VerticalDivider(
                      width: 16, // Space before and after the divider
                      thickness: 1, // Thickness of the divider
                      color: Colors.black26, // Color of the divider
                    ),
                  ),

                  //View Details Text Button
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRoutes.leadProfileScreen,
                  //       arguments: LeadDetailsArguments(
                  //         leadName: leadData.firstName,
                  //         leadEmailId: leadData.email,
                  //         leadContact: leadData.mobileNo,
                  //         leadStatus: leadData.status,
                  //         leadChannel: leadData.facebookCampaign,
                  //       ),
                  //     );
                  //   },
                  //   child: Row(
                  //     spacing: 5,
                  //     children: [
                  //       Text(
                  //         "View Details",
                  //         style: GoogleFonts.nunitoSans(
                  //           color: Colors.grey,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       ),
                  //       Icon(
                  //         Icons.north_east,
                  //         size: 15,
                  //         color: Colors.grey,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: screenWidth * 0.2, // Fixed width
                    height: screenHeight * 0.03, // Fixed height
                    decoration: BoxDecoration(
                      color: getStatusColor(
                          leadData.status ?? ""), //user.statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment
                        .center, // Center the text within the container
                    child: Text(
                      leadData.status ?? "",
                      style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Truncate the text if it's too long
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// TODO To get multiple status and set color accordingly
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
}

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return "Received On: $formattedDate";
}

// class User {
//   final String name;
//   final String email;
//   final String contact;
//   final String status;
//   final Color statusColor;

//   User({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.status,
//     required this.statusColor,
//   });
// }
