import 'dart:async';

import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view/lead_card.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view/new_lead_form.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/convert_to_deal_bloc/convert_to_deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/bottom_loader.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/overlay_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LeadsListScreen extends StatefulWidget {
  const LeadsListScreen({super.key});

  @override
  State<LeadsListScreen> createState() => _LeadsListScreenState();
}

class _LeadsListScreenState extends State<LeadsListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier<bool>(true);

  // final LeadBloc leadBloc = locator<LeadBloc>();
  // final ConvertLeadToDealBloc convertLeadToDealBloc =
  //     locator<ConvertLeadToDealBloc>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Fetch initial leads
    context.read<LeadBloc>().add(FetchLeadsEvent(limitStart: 0, limit: 10));
  }

  void _onScroll() {
    final leadBloc = context.read<LeadBloc>();
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

  Future<void> _onRefresh() async {
    final leadBloc = context.read<LeadBloc>();
    leadBloc.limitStart = 0;
    leadBloc.hasReachedMax = false;

    final Completer<void> completer = Completer<void>();
    leadBloc.add(ClearLeadsEvent());
    leadBloc.add(FetchLeadsEvent(limitStart: 0, limit: 10));

    // Listen for state change and complete when done
    leadBloc.stream
        .firstWhere((state) =>
            state.status == LeadListStatus.success ||
            state.status == LeadListStatus.failure)
        .then((_) {
      completer.complete();
    });

    return completer.future; // Ensure UI waits for refresh to complete
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LeadBloc, LeadState>(
        listener: (BuildContext context, LeadState state) {
          print("Listening ${state}");
          if (state.convertToDealStatus ==
              ConvertToDealStatus.convertToDealLoading) {
            Fluttertoast.showToast(
                msg: "Converting Lead To Deal...Please Wait");
          } else if (state.convertToDealStatus ==
              ConvertToDealStatus.convertToDealSuccess) {
            Fluttertoast.showToast(msg: "Lead Converted To Deal Successfully");
          } else if (state.convertToDealStatus ==
              ConvertToDealStatus.convertToDealFailure) {
            Fluttertoast.showToast(msg: "Failed to convert Lead To Deal");
          } else if (state.deleteLeadStatus ==
              DeleteLeadStatus.deleteLeadLoading) {
            Fluttertoast.showToast(msg: "Deleting Lead...Please Wait");
          } else if (state.deleteLeadStatus ==
              DeleteLeadStatus.deleteLeadSuccess) {
            Fluttertoast.showToast(msg: "Lead deleted Successfully");
          } else if (state.deleteLeadStatus ==
              DeleteLeadStatus.deleteLeadFailure) {
            Fluttertoast.showToast(msg: "Failed to delete Lead.");
          }
          // if (state is ConvertToDealLoadingState) {
          //   print("Listening ${state}");

          //   scaffoldMessengerKey.currentState?.showSnackBar(
          //     SnackBar(
          //       content: Text("Converting Lead To Deal...Please Wait"),
          //     ),
          //   );
          // } else if (state is ConvertToDealStateSuccessState) {
          //   print("Listening ${state}");

          //   Fluttertoast.showToast(
          //       gravity: ToastGravity.TOP,
          //       msg: "Lead Converted To Deal Successfully");
          //   scaffoldMessengerKey.currentState?.showSnackBar(
          //     SnackBar(
          //       content: Text("Lead Converted To Deal Successfully"),
          //     ),
          //   );
          // } else if (state is ConvertToDealFailureState) {
          //   scaffoldMessengerKey.currentState?.showSnackBar(
          //     SnackBar(
          //       content: Text("Failed to convert Lead To Deal"),
          //     ),
          //   );
          // }
        },
        child: RefreshIndicator.adaptive(
          key: _refreshIndicatorKey,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          semanticsLabel: 'Pull to Refresh',
          onRefresh: () async {
            await _onRefresh();
          },
          child: BlocBuilder<LeadBloc, LeadState>(
            buildWhen: (previous, current) =>
                previous.leadData !=
                    current.leadData || // Rebuild when leadData changes
                previous.selectedFilter != current.selectedFilter,
            builder: (context, state) {
              // print(
              //     "Filter: ${state.selectedFilter}, Leads Count: ${state.leadData.length}");
              // return ListView.builder(
              //   key: ValueKey(
              //       state.selectedFilter), // Force rebuild when filter changes
              //   itemCount: state.leadData.length,
              //   itemBuilder: (context, index) {
              //     return Text(state.leadData[index].toString());
              //   },
              // );
              //TODO : show different list when user searches
              // if (state.isUserSearching) {
              // } else {}
              switch (state.status) {
                case LeadListStatus.initial:
                  return LeadShimmerList(
                    itemCount: 8,
                  );
                //const Center(child: CircularProgressIndicator());
                case LeadListStatus.failure:
                  return const Center(child: Text("Failed to load leads"));
                case LeadListStatus.success:
                  return Scrollbar(
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                                // Dismissible(
                                //   key: Key(state.leadData[index].toString()),
                                //   direction: DismissDirection.endToStart,
                                //   onDismissed: (direction) {
                                //     leadBloc.add(ConvertLeadToDealEvent(
                                //         leadID:
                                //             state.leadData[index].name ?? ""));
                                //   },
                                //   background: Container(
                                //     color: Colors.black,
                                //     child: Align(
                                //       alignment: Alignment.centerRight,
                                //       child: Text(
                                //         "Convert To Deal  ",
                                //         style: GoogleFonts.nunitoSans(
                                //           fontSize: 16,
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                //   child:
                                //),
                              );
                      },
                    ),
                  );
                case LeadListStatus.contectedFilter:
                  return Scrollbar(
                    key: ValueKey(state
                        .selectedFilter), // Force rebuild when filter changes
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                              );
                      },
                    ),
                  );
                case LeadListStatus.nutureFilter:
                  return Scrollbar(
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                              );
                      },
                    ),
                  );
                case LeadListStatus.qualifiedFilter:
                  return Scrollbar(
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                              );
                      },
                    ),
                  );
                case LeadListStatus.unqualifiedFilter:
                  return Scrollbar(
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                              );
                      },
                    ),
                  );
                case LeadListStatus.junkFilter:
                  return Scrollbar(
                    controller: _scrollController,
                    thickness: 5.0,
                    radius: Radius.circular(5.0),
                    //thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount:
                          state.leadData.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        return index >= state.leadData.length
                            ? const BottomLoader()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    LeadCard(leadData: state.leadData[index]),
                              );
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          // ValueListenableBuilder<bool>(
          //   valueListenable: _isFabVisible,
          //   builder: (context, isVisible, child) {
          //     return AnimatedSwitcher(
          //       duration: Duration(milliseconds: 300),
          //       transitionBuilder: (child, animation) {
          //         return ScaleTransition(scale: animation, child: child);
          //       },
          //       child: isVisible
          //           ? FloatingActionButton(
          //               key: ValueKey(
          //                   "refreshfab_visible"), // Helps AnimatedSwitcher differentiate between old & new FAB
          //               onPressed: () async {
          //                 await _onRefresh();
          //               },
          //               child: Icon(Icons.refresh),
          //             )
          //           : SizedBox.shrink(
          //               key: ValueKey(
          //                   "refreshfab_hidden")), // Replaces FAB with an empty widget
          //     );
          //   },
          // ),
          ValueListenableBuilder<bool>(
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
        ],
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
      showDragHandle: true,
      enableDrag: true,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(
          seconds: 3,
        ),
        reverseDuration: const Duration(seconds: 2),
      ),
      isScrollControlled:
          true, // Makes the bottom sheet take full height if needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) =>
          FractionallySizedBox(heightFactor: 0.8, child: LeadFormBottomSheet()),
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
