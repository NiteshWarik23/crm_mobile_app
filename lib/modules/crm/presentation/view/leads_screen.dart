import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/modules/crm/presentation/view/crm_tabs_widget.dart';
import 'package:flutter/material.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen>  with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leads"),
        centerTitle: true,
      ),
      body: Column(
        spacing: 20.0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: SearchBar(
                  hintText: "Search...",
                  hintStyle:WidgetStateProperty.all(TextStyle(fontSize: 16),) ,
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10)),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.5), // Border Color & Width
                    ),
                  ),
                  leading: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              // Shadow color
                              spreadRadius: 0.5,
                              // Reduce spread for a smaller shadow
                              blurRadius: 5,
                              // Soften the shadow
                              offset: const Offset(0, 2))
                        ]),
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
                          color: Colors.grey.shade400,
                          // Shadow color
                          spreadRadius: 0.5,
                          // Reduce spread for a smaller shadow
                          blurRadius: 5,
                          // Soften the shadow
                          offset: const Offset(0, 2))
                    ]),
                child: Icon(
                  Icons.filter_list_sharp,
                  size: 30.0,
                ),
              ),
            ],
          ),
          CrmRoundedTabBar(tabController: _tabController,),
          Expanded(child: TabBarViewBody(tabController: _tabController,))
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
    );
  }
}



