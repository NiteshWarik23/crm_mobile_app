import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeadFormBottomSheet extends StatefulWidget {
  @override
  _LeadFormBottomSheetState createState() => _LeadFormBottomSheetState();
}

class _LeadFormBottomSheetState extends State<LeadFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _selectedStatus;
  final List<String> _leadStatuses = [
    "New",
    "In Progress",
    "Converted",
    "Lost"
  ];

  // Function to show Date Picker
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

  void _saveLead() {
    if (_formKey.currentState!.validate()) {
      // Simulating lead creation
      print("Lead Created:");
      print("Name: ${_nameController.text}");
      print("Email: ${_emailController.text}");
      print("Contact: ${_contactController.text}");
      print("Date: ${_dateController.text}");
      print("Status: $_selectedStatus");

      Navigator.pop(context); // Close bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            20, // Prevents keyboard overlap
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            Text("Create New Lead",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),

            // Lead Name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Lead Name"),
              validator: (value) =>
                  value!.isEmpty ? "Please enter a name" : null,
            ),
            SizedBox(height: 10),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              validator: (value) =>
                  value!.isEmpty ? "Please enter an email" : null,
            ),
            SizedBox(height: 10),

            // Contact Number
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(labelText: "Contact Number"),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value!.isEmpty ? "Please enter a contact number" : null,
            ),
            SizedBox(height: 10),

            // Date Picker Field
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: "Date (DD/MM/YYYY)",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context),
                ),
              ),
              readOnly: true,
              validator: (value) =>
                  value!.isEmpty ? "Please select a date" : null,
            ),
            SizedBox(height: 10),

            // Lead Status Dropdown
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _leadStatuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              decoration: InputDecoration(labelText: "Lead Status"),
              validator: (value) =>
                  value == null ? "Please select a status" : null,
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveLead,
              child: Text("Save Lead"),
            ),
          ],
        ),
      ),
    );
  }
}
