import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view/lead_card.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view/new_lead_form.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:crm_mobile_app/modules/crm/presentation/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeadsListScreen extends StatefulWidget {
  const LeadsListScreen({super.key});

  @override
  State<LeadsListScreen> createState() => _LeadsListScreenState();
}

class _LeadsListScreenState extends State<LeadsListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier<bool>(true);

  final LeadBloc leadBloc = locator<LeadBloc>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Fetch initial leads
    leadBloc.add(FetchLeadsEvent(limitStart: 0, limit: 10));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // If scrolled to bottom, hide FAB
      _isFabVisible.value = false;
      leadBloc.add(FetchLeadsEvent(
          limitStart: leadBloc.limitStart, limit: leadBloc.limit));
    } else {
      // If scrolled up, show FAB
      _isFabVisible.value = true;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          //return Future<void>.delayed(const Duration(seconds: 3));
          return leadBloc.add(FetchLeadsEvent(limitStart: 0, limit: 10));
        },
        child: BlocProvider(
          create: (context) => leadBloc,
          child: BlocBuilder<LeadBloc, LeadState>(
            builder: (context, state) {
              switch (state.status) {
                case LeadListStatus.initial:
                  return const Center(child: CircularProgressIndicator());
                case LeadListStatus.failure:
                  return const Center(child: Text("Failed to load leads"));
                case LeadListStatus.success:
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        state.leadData.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      return index >= state.leadData.length
                          ? const BottomLoader()
                          : LeadCard(leadData: state.leadData[index]);
                    },
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (context, isVisible, child) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: isVisible
                ? FloatingActionButton(
                    key: ValueKey(
                        "fab_visible"), // Helps AnimatedSwitcher differentiate between old & new FAB
                    onPressed: () => newLeadFormBottomSheetWidget(context),
                    child: Icon(Icons.add),
                  )
                : SizedBox.shrink(
                    key: ValueKey(
                        "fab_hidden")), // Replaces FAB with an empty widget
          );
        },
      ),
      // ValueListenableBuilder(
      //   valueListenable: _isFabVisible,
      //   builder: (context, value, child) {
      //     return AnimatedSlide(
      //       duration: Duration(milliseconds: 300),
      //       offset: value ? Offset(0, 0) : Offset(0, 2),
      //       child: FloatingActionButton(
      //         onPressed: () {
      //           newLeadFormBottomSheetWidget(context);
      //         },
      //         child: Icon(
      //           Icons.add,
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Future<dynamic> newLeadFormBottomSheetWidget(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Makes the bottom sheet take full height if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LeadFormBottomSheet(),
    );
  }
}
