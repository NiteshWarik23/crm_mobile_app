import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:flutter/material.dart';

void showCustomToast({
  required OverlayState overlayState,
  required LeadBloc leadBloc,
}) {
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tag saved successfully",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  overlayEntry.remove();
                  // Undo action logic here
                  leadBloc.add(ClearLeadsEvent());
                  leadBloc.add(FetchLeadsEvent(limitStart: 0, limit: 10));
                  Navigator.pop(context);
                },
                child: Text("Undo", style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  Future.delayed(Duration(seconds: 8), () {
    overlayEntry.remove();
  });
}
