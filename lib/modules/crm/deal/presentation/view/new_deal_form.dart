import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeadFormBottomSheet extends StatefulWidget {
  const LeadFormBottomSheet({super.key});

  @override
  _LeadFormBottomSheetState createState() => _LeadFormBottomSheetState();
}

class _LeadFormBottomSheetState extends State<LeadFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final _scrollController = ScrollController();
  final CreateLeadFormBloc createLeadFormBloc = locator<CreateLeadFormBloc>();

  final List<String> _salutations = [
    "Dr",
    "Madam",
    "Master",
    "Miss",
    "Mr",
    "Mrs",
    "Ms",
    "Mx",
    "Prof"
  ];
  final List<String> _genders = ["Male", "Female", "Other"];
  final List<String> _leadStatuses = [
    "New",
    "In Progress",
    "Converted",
    "Lost"
  ];
  final List<String> _employeeRanges = [
    "1-10",
    "11-50",
    "51-200",
    "201-500",
    "501-1000",
    "1000+"
  ];
  final List<String> _industries = [
    "IT",
    "Healthcare",
    "Education",
    "Finance",
    "Retail",
    "Manufacturing",
    "Other"
  ];
  final List<String> _leadStatus = [
    "New",
    "Contacted",
    "Nurture",
    "Qualified",
    "Unqualified",
    "Junk",
  ];
  final List<String> _leadOwners = ["Owner 1", "Owner 2", "Owner 3"];

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          GoogleFonts.nunitoSans(fontSize: 15, color: AppColors.greyshade500),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      suffixIcon: suffixIcon,
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createLeadFormBloc,
      child: BlocConsumer<CreateLeadFormBloc, CreateLeadFormUpdate>(
        listener: (context, state) {
          if (state.createLeadStatus == CreateLeadStatus.createLeadLoading) {
            Fluttertoast.showToast(msg: 'Creating Lead.. Please wait');
          } else if (state.createLeadStatus ==
              CreateLeadStatus.createLeadSuccess) {
            Fluttertoast.showToast(msg: 'Lead Created Successfully');
            Navigator.pop(context);
          } else if (state.createLeadStatus ==
              CreateLeadStatus.createLeadFailure) {
            Fluttertoast.showToast(msg: 'Lead Creation Failed');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset:
                true, // Ensures the UI resizes when the keyboard appears
            body: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 2.0,
              radius: Radius.circular(5.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 8,
                        top: 10,
                        bottom: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  "Create New Lead",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 15),
                              _buildLabel("Salutation"),
                              DropdownButtonFormField(
                                value: state.salutation.isEmpty
                                    ? null
                                    : state.salutation,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    color: AppColors.greyshade500),
                                items: _salutations.map((salutation) {
                                  return DropdownMenuItem(
                                      value: salutation,
                                      child: Text(salutation));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc.add(UpdateFormField(
                                      salutation: value.toString()));
                                },

                                // setState(() => _selectedSalutation = value),
                                decoration:
                                    _inputDecoration("Select Salutation"),
                              ),
                              SizedBox(height: 10),
                              _buildLabel("First Name *"),
                              TextFormField(
                                controller: _firstNameController,
                                decoration:
                                    _inputDecoration("Enter First Name"),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(firstName: value));
                                },
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Last Name"),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: _inputDecoration("Enter Last Name"),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(lastName: value));
                                },
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Email"),
                              TextFormField(
                                  controller: _emailController,
                                  onChanged: (value) {
                                    createLeadFormBloc
                                        .add(UpdateFormField(email: value));
                                  },
                                  decoration:
                                      _inputDecoration("Enter Email Address")),
                                       SizedBox(height: 10),
                              _buildLabel("Mobile No"),
                              TextFormField(
                                  controller: _contactController,
                                  onChanged: (value) {
                                    createLeadFormBloc
                                        .add(UpdateFormField(contact: value));
                                  },
                                  decoration:
                                      _inputDecoration("Enter Mobile Number")),
                              SizedBox(height: 10),
                              _buildLabel("Gender"),
                              DropdownButtonFormField(
                                value:
                                    state.gender.isEmpty ? null : state.gender,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    color: AppColors.greyshade500),
                                items: _genders.map((gender) {
                                  return DropdownMenuItem(
                                      value: gender, child: Text(gender));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(gender: value));
                                },
                                decoration: _inputDecoration("Select Gender"),
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Organization"),
                              TextFormField(
                                  controller: _organizationController,
                                  onChanged: (value) {
                                    createLeadFormBloc.add(
                                        UpdateFormField(organization: value));
                                  },
                                  decoration: _inputDecoration(
                                      "Enter Organization Name")),
                              SizedBox(height: 10),
                              _buildLabel("Website"),
                              TextFormField(
                                  controller: _websiteController,
                                  onChanged: (value) {
                                    createLeadFormBloc
                                        .add(UpdateFormField(website: value));
                                  },
                                  decoration:
                                      _inputDecoration("Enter Website URL")),
                              SizedBox(height: 10),
                              _buildLabel("Number of Employees"),
                              DropdownButtonFormField(
                                value: state.numberOfEmployees.isEmpty
                                    ? null
                                    : state.numberOfEmployees,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    color: AppColors.greyshade500),
                                items: _employeeRanges.map((range) {
                                  return DropdownMenuItem(
                                      value: range, child: Text(range));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc.add(UpdateFormField(
                                      numberOfEmployees: value));
                                },
                                decoration:
                                    _inputDecoration("Select Employee Range"),
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Industry"),
                              DropdownButtonFormField(
                                value: state.industry.isEmpty
                                    ? null
                                    : state.industry,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    color: AppColors.greyshade500),
                                items: _industries.map((industry) {
                                  return DropdownMenuItem(
                                      value: industry, child: Text(industry));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(industry: value));
                                },
                                decoration: _inputDecoration("Select Industry"),
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Lead Status"),
                              DropdownButtonFormField(
                                value: state.leadStatus.isEmpty
                                    ? _leadStatus.first.toString()
                                    : state.leadStatus,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 15,
                                  color: AppColors.greyshade500,
                                ),
                                items: _leadStatus.map((status) {
                                  return DropdownMenuItem(
                                      value: status,
                                      child: Text(
                                        status,
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(leadOwner: value));
                                },
                                decoration:
                                    _inputDecoration("Select Lead Status"),
                              ),
                              SizedBox(height: 10),
                              _buildLabel("Lead Owner"),
                              DropdownButtonFormField(
                                value: state.leadOwner.isEmpty
                                    ? null
                                    : state.leadOwner,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    color: AppColors.greyshade500),
                                items: _leadOwners.map((owner) {
                                  return DropdownMenuItem(
                                      value: owner, child: Text(owner));
                                }).toList(),
                                onChanged: (value) {
                                  createLeadFormBloc
                                      .add(UpdateFormField(leadOwner: value));
                                },
                                decoration:
                                    _inputDecoration("Select Lead Owner"),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: createLeadButton(context, state),
          );
        },
      ),
    );
  }

  Widget createLeadButton(BuildContext context, CreateLeadFormUpdate state) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: MediaQuery.of(context).viewInsets.bottom == 0
          ? FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              backgroundColor: state.firstName.isNotEmpty ? Colors.black : Colors.grey,
              enableFeedback: true,
              onPressed: state.firstName.isNotEmpty
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        createLeadFormBloc.add(SubmitLeadForm());
                      }
                    }
                  : null,
              icon: Icon(Icons.save_sharp, color: state.firstName.isNotEmpty ? Colors.white : Colors.white),
              label: Text("Create Lead",
                  style: TextStyle(color: state.firstName.isNotEmpty ? Colors.white : Colors.white, fontSize: 16)),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: GoogleFonts.nunitoSans(
              fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
