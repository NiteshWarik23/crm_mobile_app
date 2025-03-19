// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/dropdown_bloc/dropdown_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/dropdown_bloc/dropdown_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/dropdown_bloc/dropdown_state.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_state.dart';

void showDropdownBottomSheet(BuildContext context, String leadID) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DropDownBottomSheet(
        leadIDValue: leadID,
      );
    },
  );
}

class DropDownBottomSheet extends StatelessWidget {
  final String leadIDValue;
  DropDownBottomSheet({
    super.key,
    required this.leadIDValue,
  });

  final LeadBloc leadBloc = locator<LeadBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DropdownBloc(),
        ),
        BlocProvider(create: (context) => leadBloc)
      ],
      child: BlocListener<LeadBloc, LeadState>(
        listener: (context, state) {
          if (state.status ==LeadListStatus.updateLeadStatusSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Lead Status Updated"),
              ),
            );
            Navigator.pop(context);
          } else if (state.status == LeadListStatus.updateLeadStatusFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed to update Lead Status"),
              ),
            );
          }
        },
        child: BlocBuilder<DropdownBloc, DropdownState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Update Status",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
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
                                  offset: const Offset(
                                      0, 2), // Subtle vertical shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.close_sharp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: state.selectedOption.isEmpty
                          ? null
                          : state.selectedOption,
                      hint: Text(
                        "Select a Status",
                        style: GoogleFonts.nunitoSans(fontSize: 16),
                      ),
                      items: [
                        "New",
                        "Contacted",
                        "Nurture",
                        "Qualified",
                        "Unqualified",
                        "Junk",
                      ]
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(
                                  option,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<DropdownBloc>()
                            .add(DropdownChanged(value!));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 15,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: state.selectedOption.isNotEmpty
                              ? () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Selected: ${state.selectedOption}"),
                                    ),
                                  );
                                  leadBloc.add(UpdateLeadStatusEvent(
                                      leadID: leadIDValue,
                                      status: state.selectedOption));
                                }
                              : null,
                          child: Text(
                            "Update",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
