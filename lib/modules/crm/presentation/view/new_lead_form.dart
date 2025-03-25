import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_lead_bloc/create_lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_lead_bloc/create_lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_lead_bloc/create_lead_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeadFormBottomSheet extends StatefulWidget {
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

  String? _selectedSalutation;
  String? _selectedGender;
  String? _selectedStatus;
  String? _selectedEmployees;
  String? _selectedIndustry;
  String? _selectedLeadOwner;

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

  void _saveLead() {
    if (_formKey.currentState!.validate()) {
      print("Lead Created:");
      print("Salutation: $_selectedSalutation");
      print("First Name: ${_firstNameController.text}");
      print("Last Name: ${_lastNameController.text}");
      print("Email: ${_emailController.text}");
      print("Contact: ${_contactController.text}");
      print("Organization: ${_organizationController.text}");
      print("Website: ${_websiteController.text}");
      print("Number of Employees: $_selectedEmployees");
      print("Industry: $_selectedIndustry");
      print("Lead Owner: $_selectedLeadOwner");
      print("Date: ${_dateController.text}");
      print("Status: $_selectedStatus");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createLeadFormBloc,
      child: BlocConsumer<CreateLeadFormBloc, CreateLeadFormState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CreateLeadFormUpdate) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 8,
                  top: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    thickness: 2.0,
                    radius: Radius.circular(5.0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 15),
                            _buildLabel("Salutation"),
                            DropdownButtonFormField(
                              value: state.salutation,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 15, color: AppColors.greyshade500),
                              items: _salutations.map((salutation) {
                                return DropdownMenuItem(
                                    value: salutation, child: Text(salutation));
                              }).toList(),
                              onChanged: (value) {
                                createLeadFormBloc.add(UpdateFormField(
                                    salutation: value.toString()));
                              },

                              // setState(() => _selectedSalutation = value),
                              decoration: _inputDecoration("Select Salutation"),
                            ),
                            SizedBox(height: 10),
                            _buildLabel("First Name *"),
                            TextFormField(
                              controller: _firstNameController,
                              decoration: _inputDecoration("Enter First Name"),
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
                            _buildLabel("Gender"),
                            DropdownButtonFormField(
                              value: _selectedGender,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 15, color: AppColors.greyshade500),
                              items: _genders.map((gender) {
                                return DropdownMenuItem(
                                    value: gender, child: Text(gender));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedGender = value),
                              decoration: _inputDecoration("Select Gender"),
                            ),
                            SizedBox(height: 10),
                            _buildLabel("Organization"),
                            TextFormField(
                                controller: _organizationController,
                                decoration: _inputDecoration(
                                    "Enter Organization Name")),
                            SizedBox(height: 10),
                            _buildLabel("Website"),
                            TextFormField(
                                controller: _websiteController,
                                decoration:
                                    _inputDecoration("Enter Website URL")),
                            SizedBox(height: 10),
                            _buildLabel("Number of Employees"),
                            DropdownButtonFormField(
                              value: _selectedEmployees,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 15, color: AppColors.greyshade500),
                              items: _employeeRanges.map((range) {
                                return DropdownMenuItem(
                                    value: range, child: Text(range));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedEmployees = value),
                              decoration:
                                  _inputDecoration("Select Employee Range"),
                            ),
                            SizedBox(height: 10),
                            _buildLabel("Industry"),
                            DropdownButtonFormField(
                              value: _selectedIndustry,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 15, color: AppColors.greyshade500),
                              items: _industries.map((industry) {
                                return DropdownMenuItem(
                                    value: industry, child: Text(industry));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedIndustry = value),
                              decoration: _inputDecoration("Select Industry"),
                            ),
                            SizedBox(height: 10),
                            _buildLabel("Lead Owner"),
                            DropdownButtonFormField(
                              value: _selectedLeadOwner,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 15, color: AppColors.greyshade500),
                              items: _leadOwners.map((owner) {
                                return DropdownMenuItem(
                                    value: owner, child: Text(owner));
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedLeadOwner = value),
                              decoration: _inputDecoration("Select Lead Owner"),
                            ),
                            SizedBox(height: 10),
                            _buildLabel("Date"),
                            TextFormField(
                              controller: _dateController,
                              decoration: _inputDecoration(
                                "Select Date",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () => _pickDate(context),
                                ),
                              ),
                              readOnly: true,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
                backgroundColor: Colors.black,
                enableFeedback: true,
                onPressed: _saveLead,
                icon: Icon(Icons.save_sharp, color: Colors.white),
                label: Text("Create Lead",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            );
          }
          return SizedBox();
        },
      ),
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
