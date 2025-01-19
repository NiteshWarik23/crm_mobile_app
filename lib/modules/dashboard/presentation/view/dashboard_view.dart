import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_header_view.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_event.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _screens = [
    DashboardHeader(),
    SearchPage(),
    AddPage(),
    AlertsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          if (state is BottomNavInitial) {
            return _screens[state.index];
          } else if (state is BottomNavUpdatedState) {
            return _screens[state.index];
          }
          return _screens[0];
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          left: 10.0,
          bottom: 15.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: AppColors.greenshade01,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex:
                (context.watch<BottomNavBloc>().state is BottomNavUpdatedState)
                    ? (context.watch<BottomNavBloc>().state
                            as BottomNavUpdatedState)
                        .index
                    : 0,
            onTap: (index) {
              context.read<BottomNavBloc>().add(UpdateIndex(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: DashboardHeader(),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Search Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Add Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Alerts Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Profile Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  }
}

//****************************************Example 2*******************************/

// import 'package:crm_mobile_app/modules/dashboard/presentation/view/dashboard_header_view.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     DashboardHeader(),
//     SearchPage(),
//     AddPage(),
//     AlertsPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Column(
//         children: [
//           Expanded(
//             child: _screens[_selectedIndex],
//           ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(
//           right: 10.0,
//           left: 10.0,
//           bottom: 10.0,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.black,
//             selectedItemColor: Colors.blue,
//             unselectedItemColor: Colors.grey,
//             showSelectedLabels: true,
//             showUnselectedLabels: true,
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 label: 'Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.add_circle_outline),
//                 label: 'Add',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.notifications),
//                 label: 'Alerts',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text('Search Page',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
//   }
// }

// class AddPage extends StatelessWidget {
//   const AddPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text('Add Page',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
//   }
// }

// class AlertsPage extends StatelessWidget {
//   const AlertsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text('Alerts Page',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
//   }
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text('Profile Page',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
//   }
// }
