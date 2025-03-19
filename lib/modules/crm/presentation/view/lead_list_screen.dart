import 'dart:async';

import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/main.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view/lead_card.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view/new_lead_form.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:crm_mobile_app/modules/crm/presentation/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    leadBloc.add(ClearLeadsEvent()); // Reset the list when exiting
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
          leadBloc.limitStart = 0;
          leadBloc.hasReachedMax = false;

          // final Completer<void> completer = Completer<void>();

          // // Listen for state change and complete when done
          // leadBloc.stream
          //     .firstWhere((state) =>
          //         state.status == LeadListStatus.success ||
          //         state.status == LeadListStatus.failure)
          //     .then((_) {
          //   completer.complete();
          // });
          leadBloc.add(ClearLeadsEvent());
          return leadBloc.add(FetchLeadsEvent(limitStart: 0, limit: 10));

          //return completer.future; // Ensure UI waits for refresh to complete
        },
        child: BlocProvider(
          create: (context) => leadBloc,
          child: BlocBuilder<LeadBloc, LeadState>(
            builder: (context, state) {
              switch (state.status) {
                case LeadListStatus.initial:
                  return LeadShimmerList(
                    itemCount: 8,
                  );
                //const Center(child: CircularProgressIndicator());
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
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Dismissible(
                                  key: Key(state.leadData[index].toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    leadBloc.add(ConvertLeadToDealEvent(
                                        leadID:
                                            state.leadData[index].name ?? ""));
                                  },
                                  background: Container(
                                    color: Colors.black,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Convert To Deal  ",
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: LeadCard(
                                      leadData: state.leadData[index])),
                            );
                    },
                  );

                case LeadListStatus.convertToDealSuccess:
                  return SizedBox();
                case LeadListStatus.convertToDealFailure:
                  return SizedBox();
                case LeadListStatus.updateLeadStatusSuccess:
                  return SizedBox();
                case LeadListStatus.updateLeadStatusFailure:
                  return SizedBox();
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text("Logging in...")),
                // );
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

  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error Occurred!")),
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

class SwipeToDismissExample extends StatefulWidget {
  @override
  _SwipeToDismissExampleState createState() => _SwipeToDismissExampleState();
}

class _SwipeToDismissExampleState extends State<SwipeToDismissExample> {
  List<String> items = List.generate(10, (index) => 'Lead ${index + 1}');

  Future<void> _deleteLead(int index) async {
    String leadId = items[index];

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      items.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$leadId deleted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swipe to Dismiss")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Delete",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(width: 10),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (direction) {
              _deleteLead(index);
            },
            child: ListTile(
              title: Text(items[index]),
              trailing:
                  Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

class CustomShimmer extends StatefulWidget {
  final Widget child;
  const CustomShimmer({Key? key, required this.child}) : super(key: key);

  @override
  _CustomShimmerState createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LeadCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Avatar Shimmer
                CustomShimmer(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Shimmer
                      CustomShimmer(
                        child: Container(
                          height: 16,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Email Shimmer
                      CustomShimmer(
                        child: Container(
                          height: 12,
                          width: screenWidth * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Contact Number Shimmer
                      CustomShimmer(
                        child: Container(
                          height: 12,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Campaign Name Shimmer
                      CustomShimmer(
                        child: Container(
                          height: 12,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                // Status Box Shimmer
                CustomShimmer(
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.03,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Shimmer
                CustomShimmer(
                  child: Container(
                    height: 12,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                  child: VerticalDivider(
                    width: 16,
                    thickness: 1,
                    color: Colors.black26,
                  ),
                ),
                // View Details Shimmer
                CustomShimmer(
                  child: Container(
                    height: 12,
                    width: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeadShimmerList extends StatelessWidget {
  final int itemCount; // Number of shimmer items

  const LeadShimmerList({Key? key, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        itemCount: itemCount, // Show 5-8 shimmer items
        itemBuilder: (context, index) => LeadCardShimmer(),
      ),
    );
  }
}
