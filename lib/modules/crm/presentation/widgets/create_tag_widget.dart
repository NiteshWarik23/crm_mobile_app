// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_tag_bloc/create_tag_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_tag_bloc/create_tag_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/create_tag_bloc/create_tag_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCreateTagBottomSheet(BuildContext context, String leadID) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FractionallySizedBox(
          heightFactor: 0.7,
          child: AddTagBottomSheet(
            leadIDValue: leadID,
          ));
    },
  );
}

class AddTagBottomSheet extends StatefulWidget {
  final String leadIDValue;

  AddTagBottomSheet({
    Key? key,
    required this.leadIDValue,
  }) : super(key: key);

  @override
  State<AddTagBottomSheet> createState() => _AddTagBottomSheetState();
}

class _AddTagBottomSheetState extends State<AddTagBottomSheet> {
  final TextEditingController _tagController = TextEditingController();

  final List<String> predefinedTags = [
    "High Priority",
    "Low Priority",
    "Follow Up",
    "Done"
  ];

  List<String> selectedTags = [];
  String? selectedTag; // Track the selected tag (Single Selection)
  final CreateTagBloc createTagBloc = locator<CreateTagBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createTagBloc,
      child: BlocListener<CreateTagBloc,CreateTagState>(
        listener: (context, state) {
          if (state is CreateTagLoadingState) {
            Fluttertoast.showToast(msg: "Adding Tag...Please Wait");
          } else if (state is CreateTagSuccessState) {
            Fluttertoast.showToast(msg: "Tag Added Succesfully.");
            Navigator.pop(context);
          } else if (state is CreateTagFailureState) {
            Fluttertoast.showToast(msg: "Failed To Add Tag");
            Navigator.pop(context);
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Tags",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // TextField for Adding Custom Tags
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: InputDecoration(
                        hintText: "Enter tag",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _tagController.text.isNotEmpty
                        ? () {
                            if (_tagController.text.isNotEmpty) {
                              setState(() {
                                predefinedTags.add(_tagController.text);
                              });
                            }
                          }
                        : null,
                    child: Text("Add"),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Predefined Tags
              Wrap(
                spacing: 8,
                children: predefinedTags.map((tag) {
                  return ChoiceChip(
                    label: Text(tag),
                    selected: selectedTag == tag,
                    //selectedTags.contains(tag),
                    onSelected: (selected) {
                      setState(() {
                        selectedTag = selected ? tag : null;
                      });
                      //setState(() {
                      // if (selected) {
                      //   selectedTags.add(tag);
                      // } else {
                      //   selectedTags.removeWhere((String item) => item == tag);
                      // }
                      // });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 10),

              // Selected Tags
              // Wrap(
              //   spacing: 8,
              //   children: selectedTags.map((tag) {
              //     return Chip(
              //       label: Text(tag),
              //       deleteIcon: Icon(Icons.close),
              //       onDeleted: () {
              //         setState(() {
              //           selectedTags.removeWhere((String item) => item == tag);
              //         });
              //         //context.read<TagBloc>().add(RemoveTagEvent(tag));
              //       },
              //     );
              //   }).toList(),
              // ),
              SizedBox(height: 10),
              Spacer(),
              // Save Button
              BlocBuilder<CreateTagBloc, CreateTagState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: selectedTag != null
                          ? () {
                              createTagBloc.add(
                                SaveOneCreatedOrSelectedTagsEvent(
                                  createdOrSelectedTags: selectedTag ?? '',
                                  leadIdValue: widget.leadIDValue,
                                ),
                              );
                            }
                          : null,
                      child: Text("Save"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
