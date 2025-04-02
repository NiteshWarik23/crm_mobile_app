import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void showCreateNoteBottomSheet(BuildContext context, String leadID) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FractionallySizedBox(
          heightFactor: 0.7,
          child: CreateNoteScreen(
            leadId: leadID,
          ));
    },
  );
}

class CreateNoteScreen extends StatefulWidget {
  final String leadId; // Lead ID for associating the note

  const CreateNoteScreen({super.key, required this.leadId});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final CreateNoteBloc createNoteBloc = locator<CreateNoteBloc>();

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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
          style: GoogleFonts.nunitoSans(
              fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createNoteBloc, // Providing the BLoC
      child: Padding(
        padding: const EdgeInsets.only(
            right: 16.0, left: 16.0, bottom: 16.0, top: 00.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text("Add Note",
                style: GoogleFonts.nunitoSans(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            _buildLabel("Title"),
            // Title Field
            TextField(
              controller: _titleController,
              decoration: _inputDecoration("Call with John Doe"),
            ),
            //SizedBox(height: 16),
            _buildLabel("Content"),
            // Content Field
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: _inputDecoration(
                  "Took a call with John Doe and discussed the new project."),
            ),
            //SizedBox(height: 16),
            Spacer(),
            // Bloc Listener for State Handling
            BlocListener<CreateNoteBloc, CreateNoteState>(
              listener: (context, state) {
                if (state is CreateNoteSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Note added successfully")),
                  );
                  Navigator.pop(context, true); // Return success
                } else if (state is CreateNoteFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to add note")),
                  );
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    backgroundColor: _titleController.text.isNotEmpty &&
                            _contentController.text.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                  ),
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _titleController.text.isNotEmpty) {
                      createNoteBloc.add(
                        SubmitCreatedNoteEvent(
                          title: _titleController.text.toString().trim(),
                          content: _contentController.text.toString().trim(),
                          leadId: widget.leadId,
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Please fill all fields");
                    }
                  },
                  icon: Icon(Icons.create,
                      color: _titleController.text.isNotEmpty &&
                              _contentController.text.isNotEmpty
                          ? Colors.white
                          : Colors.white),
                  label: Text("Create Note",
                      style: TextStyle(
                          color: _titleController.text.isNotEmpty &&
                                  _contentController.text.isNotEmpty
                              ? Colors.white
                              : Colors.white,
                          fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
