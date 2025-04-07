
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_event.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DealFilterScreen extends StatefulWidget {
  const DealFilterScreen({super.key});

  @override
  State<DealFilterScreen> createState() => _DealFilterScreenState();
}

class _DealFilterScreenState extends State<DealFilterScreen> {
  final List<DealFilter> filters = [
    DealFilter.all,
    DealFilter.qualification,
    DealFilter.demoMaking,
    DealFilter.proposalQuotation,
    DealFilter.negotiation,
    DealFilter.readyToClose,
    DealFilter.won,
    DealFilter.lost,
  ];

  //final LeadBloc leadBloc = locator<LeadBloc>();
  DealFilter selectedDealFilter = DealFilter.all;

  @override
  Widget build(BuildContext context) {
    final dealBloc = context.read<DealBloc>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          spacing: 10.0,
          children: filters.map((filter) {
            return ChoiceChip(
              showCheckmark: false,
              label: Text(
                selectedDealFilter == filter
                    ? filter.name.toUpperCase()
                    : filter.name.toLowerCase(),
                style: GoogleFonts.nunitoSans(
                    fontWeight: selectedDealFilter == filter
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedDealFilter == filter
                        ? Colors.white
                        : Colors.grey[700],
                    fontSize: 15),
              ),
              selected: selectedDealFilter == filter,
              onSelected: (isSelected) {
                if (isSelected) {
                  setState(() {
                    selectedDealFilter = filter;
                  });
                  dealBloc.limitStart = 0;
                  dealBloc.hasReachedMax = false;
                  dealBloc.add(ClearDealsEvent());
                  dealBloc.add(FetchDealsEvent(
                      limitStart: 0, limit: 10, dealFilter: selectedDealFilter));
                }
              },
              selectedColor: AppColors.greenshade01, // Background when selected
              backgroundColor: Colors.grey[300], // Background when not selected
              shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
              labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              avatar: selectedDealFilter == filter
                  ? CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: Icon(Icons.check, color: Colors.white, size: 15),
                    )
                  : null,
              visualDensity: VisualDensity(horizontal: 0, vertical: -3),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ),
    );
  }
}
