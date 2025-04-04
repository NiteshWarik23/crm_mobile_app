import 'dart:async';

import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadFilterScreen extends StatefulWidget {
  LeadFilterScreen({super.key});

  @override
  State<LeadFilterScreen> createState() => _LeadFilterScreenState();
}

class _LeadFilterScreenState extends State<LeadFilterScreen> {
  final List<LeadFilter> filters = [
    LeadFilter.all,
    LeadFilter.contacted,
    LeadFilter.nurture,
    LeadFilter.qualified,
    LeadFilter.unqualified,
    LeadFilter.junk,
  ];

  //final LeadBloc leadBloc = locator<LeadBloc>();
  LeadFilter selectedFilter = LeadFilter.all;

  @override
  Widget build(BuildContext context) {
    final leadBloc = context.read<LeadBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10.0,
        children: filters.map((filter) {
          return ChoiceChip(
            label: Text(filter.name.toLowerCase()),
            selected: selectedFilter == filter,
            onSelected: (isSelected) {
              if (isSelected) {
                setState(() {
                  selectedFilter = filter;
                });
                leadBloc.limitStart = 0;
                leadBloc.hasReachedMax = false;
                leadBloc.add(ClearLeadsEvent());
                leadBloc.add(FetchLeadsEvent(
                    limitStart: 0, limit: 10, filter: selectedFilter));
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
