import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/models/response/get_notes_response_model.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view/lead_list_screen.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_event.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_state.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showViewNotesBottomSheet(BuildContext context, String leadID) {
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
          child: ViewNotesListScreen(
            leadIDValue: leadID,
          ));
    },
  );
}

class ViewNotesListScreen extends StatefulWidget {
  final String leadIDValue;

  const ViewNotesListScreen({super.key, required this.leadIDValue});

  @override
  State<ViewNotesListScreen> createState() => _ViewNotesListScreenState();
}

class _ViewNotesListScreenState extends State<ViewNotesListScreen> {
  final _scrollController = ScrollController();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier<bool>(true);
  final GetNotesBloc getNotesBloc = locator<GetNotesBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Fetch initial leads
    getNotesBloc.add(FetchNotesEvent(
        leadIDValue: widget.leadIDValue, limitStart: 0, limit: 10));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // If scrolled to bottom, hide FAB
      _isFabVisible.value = false;
      getNotesBloc.add(FetchNotesEvent(
          leadIDValue: widget.leadIDValue,
          limitStart: getNotesBloc.limitStart,
          limit: getNotesBloc.limit));
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
      appBar: AppBar(
        title: Text("Notes"),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) => getNotesBloc,
        child: BlocBuilder<GetNotesBloc, GetNotesState>(
          builder: (context, state) {
            switch (state.getNotesListStatus) {
              case GetNotesListStatus.getNotesListInitial:
                return LeadShimmerList(
                  itemCount: 8,
                );
              case GetNotesListStatus.getNotesListLoading:
                return LeadShimmerList(
                  itemCount: 8,
                );
              //const Center(child: CircularProgressIndicator());
              case GetNotesListStatus.getNotesListFailure:
                return const Center(child: Text("Failed to load Notes"));
              case GetNotesListStatus.getNotesListSuccess:
                return Scrollbar(
                  controller: _scrollController,
                  thickness: 5.0,
                  radius: Radius.circular(5.0),
                  //thumbVisibility: true,
                  trackVisibility: true,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.notesListData.length +
                        (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      return index >= state.notesListData.length
                          ? const BottomLoader()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: NotesCardWidget(
                                  note: state.notesListData[index]),
                              //LeadCard(leadData: state.leadData[index]),
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
            }
            // if (state is NotesLoadingState) {
            //   return Center(child: CircularProgressIndicator());
            // } else if (state is NotesLoadedState) {
            //   return ListView.builder(
            //     itemCount: state.notes.length,
            //     itemBuilder: (context, index) {
            //       final note = state.notes[index];
            //       return Card(
            //         child: ListTile(
            //           title: Text(note.title),
            //           subtitle: Text(note.content,
            //               maxLines: 2, overflow: TextOverflow.ellipsis),
            //           trailing: IconButton(
            //             icon: Icon(Icons.edit, color: Colors.blue),
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => EditNoteScreen(note: note),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   );
            // } else if (state is NotesErrorState) {
            //   return Center(child: Text("Failed to load notes"));
            // }
            // return Center(child: Text("No notes found"));
          },
        ),
      ),
    );
  }
}

class NotesCardWidget extends StatelessWidget {
  const NotesCardWidget({
    super.key,
    required this.note,
  });

  final NotesListData note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(note.title ?? "NA"),
        subtitle: Text(note.content ?? "NA",
            maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {},
            //         //EditNoteScreen(note: note),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
