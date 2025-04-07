import 'package:crm_mobile_app/core/dependency%20injection/dependency_injection.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view/crm_tabs_widget.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/widgets/leads_filter_chips_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  late TabController _tabController;
  final LeadBloc leadBloc = locator<LeadBloc>();
  final DealBloc dealBloc = locator<DealBloc>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: leadBloc,
        ),
        BlocProvider.value(
          value: dealBloc,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Leads",
            style: GoogleFonts.nunitoSans(
                fontSize: 18, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          spacing: 15.0,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.055,
                  child: SearchBar(
                    hintText: "Search...",
                    hintStyle: WidgetStateProperty.all(
                      GoogleFonts.nunitoSans(
                          fontSize: 16, color: Colors.grey.shade600),
                    ),
                    elevation: WidgetStateProperty.all(0.0),
                    textInputAction: TextInputAction.search,
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10)),
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.5), // Border Color & Width
                      ),
                    ),
                    leading: Container(
                      height: 25,
                      width: 25,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(50),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           color: Colors.grey.shade200,
                      //           // Shadow color
                      //           spreadRadius: 0.5,
                      //           // Reduce spread for a smaller shadow
                      //           blurRadius: 5,
                      //           // Soften the shadow
                      //           offset: const Offset(0, 2))
                      //     ]),
                      child: Icon(
                        Icons.search,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            // Shadow color
                            spreadRadius: 0.5,
                            // Reduce spread for a smaller shadow
                            blurRadius: 5,
                            // Soften the shadow
                            offset: const Offset(0, 2))
                      ]),
                  child: Icon(
                    Icons.swap_vert,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            CrmRoundedTabBar(
              tabController: _tabController,
            ),
            //SingleChoice(),
           // LeadFilterScreen(),
            Expanded(
                child: TabBarViewBody(
              tabController: _tabController,
            )),
          ],
        ),
        // bottomNavigationBar: NavigationBar(
        //   onDestinationSelected: (int index) {
        //     setState(() {
        //       currentPageIndex = index;
        //     });
        //   },
        //   indicatorColor: Colors.amber,
        //   selectedIndex: currentPageIndex,
        //   destinations: const <Widget>[
        //     NavigationDestination(
        //       selectedIcon: Icon(Icons.home),
        //       icon: Icon(Icons.home_outlined),
        //       label: 'Home',
        //     ),
        //     NavigationDestination(
        //       icon: Badge(child: Icon(Icons.notifications_sharp)),
        //       label: 'Notifications',
        //     ),
        //     NavigationDestination(
        //       icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
        //       label: 'Messages',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SegmentedButton<Calendar>(
          segments: const <ButtonSegment<Calendar>>[
            ButtonSegment<Calendar>(
              value: Calendar.day,
              label: Text('Day'),
              icon: Icon(Icons.calendar_view_day),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.week,
              label: Text('Week'),
              icon: Icon(Icons.calendar_view_week),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.month,
              label: Text('Month'),
              icon: Icon(Icons.calendar_view_month),
            ),
            ButtonSegment<Calendar>(
              value: Calendar.year,
              label: Text('Year'),
              icon: Icon(Icons.calendar_today),
            ),
          ],
          selected: <Calendar>{calendarView},
          onSelectionChanged: (Set<Calendar> newSelection) {
            setState(() {
              // By default there is only a single segment that can be
              // selected at one time, so its value is always the first
              // item in the selected set.
              calendarView = newSelection.first;
            });
          },
        ),
      ),
    );
  }
}
