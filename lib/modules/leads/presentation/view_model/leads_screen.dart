import 'package:crm_mobile_app/config/routes/routes.dart';
import 'package:crm_mobile_app/modules/leads/presentation/view_model/calender_screen.dart';
import 'package:flutter/material.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {

  int _selectedIndex = 0;

  final List<String> _tabs = ["Leads", "Deals", "Calendar"];

  final List<User> users = [
    User(
        name: "Anna Smith",
        email: "annasmith12@gmail.com",
        contact: "0987654321",
        status: "In Progress",
        statusColor: Color(0xFF009963)),
    User(
        name: "Carla Cardos",
        email: "Carla87@gmail.com",
        contact: "0987654321",
        status: "On Hold",
        statusColor: Color(0xFF91C1ED)),
    User(
        name: "Hannah Smith",
        email: "hannahsmith84@gmail.com",
        contact: "0987654321",
        status: "Closed",
        statusColor: Color(0xFFD19191)),
    User(
        name: "Aanya",
        email: "Anyadsouza09@gmail.com",
        contact: "0987654321",
        status: "In Progress",
        statusColor: Color(0xFF009963)),
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth, // Set the width
            height: screenHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            // Shadow color
                            spreadRadius: 0.5,
                            // Reduce spread for a smaller shadow
                            blurRadius: 5,
                            // Soften the shadow
                            offset:
                                const Offset(0, 2), // Subtle vertical shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 4, top: 2, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Search Icon Button
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.white, // Button background color
                                shape: BoxShape.circle, // Makes it circular
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    // Shadow color
                                    spreadRadius: 0.5,
                                    // Reduce spread for a smaller shadow
                                    blurRadius: 5,
                                    // Soften the shadow
                                    offset: const Offset(
                                        0, 2), // Subtle vertical shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.search_sharp, // Search icon
                                color: Colors.black, // Icon color
                                size: 20, // Icon size
                              ),
                            ),
                            // Expanded TextField
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                // Add spacing between the icon and TextField
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  // Vertically center the text
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // Remove the default bottom line
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 16), // Adjust the font size
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Filter Icon Button
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Button background color
                      shape: BoxShape.circle, // Makes it circular
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          // Shadow color
                          spreadRadius: 0.5,
                          // Reduce spread for a smaller shadow
                          blurRadius: 5,
                          // Soften the shadow
                          offset: const Offset(0, 2), // Subtle vertical shadow
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.filter_list_sharp, // Filter icon
                      color: Colors.black, // Icon color
                      size: 20, // Icon size
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          SizedBox(
            width: screenWidth, // Set the width
            height: screenHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            // Shadow color
                            spreadRadius: 0.5,
                            // Reduce spread for a smaller shadow
                            blurRadius: 5,
                            // Soften the shadow
                            offset:
                            const Offset(0, 2), // Subtle vertical shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_tabs.length, (index) {
                          final isSelected = _selectedIndex == index;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? Color(0xFF009963) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _tabs[index],
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Color(0xFF009963),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          _selectedIndex == 0 || _selectedIndex == 1 ?
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user);
              },
            ),
          ) : Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppointmentScreen(),
          )
        ],
      ),
    );
  }
}


class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the top
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown, // Scales the text down to fit
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown, // Scales the text down to fit
                        child: Text(
                          "Email : ${user.email}",
                          maxLines: 1, // Restrict to a single line
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontSize: 12,color: Colors.grey),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown, // Scales the text down to fit
                        child: Text(
                          "Contact : ${user.contact}",
                          maxLines: 1, // Restrict to a single line
                          style: TextStyle(fontSize: 12,color: Colors.grey),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown, // Scales the text down to fit
                        child: Text(
                          "Campaign Name",
                          maxLines: 1, // Restrict to a single line
                          style: TextStyle(fontSize: 12,color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.2, // Fixed width
                  height: screenHeight * 0.03, // Fixed height
                  decoration: BoxDecoration(
                    color: user.statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center, // Center the text within the container
                  child: Text(
                    user.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Truncate the text if it's too long
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Received On: 20/05/2024",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                // Add a SizedBox with height to make the VerticalDivider visible
                SizedBox(
                  height: screenHeight * 0.02, // Set height to match the content
                  child: VerticalDivider(
                    width: 16, // Space before and after the divider
                    thickness: 1, // Thickness of the divider
                    color: Colors.black26, // Color of the divider
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.leadProfileScreen);
                  },
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
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

class User {
  final String name;
  final String email;
  final String contact;
  final String status;
  final Color statusColor;

  User({
    required this.name,
    required this.email,
    required this.contact,
    required this.status,
    required this.statusColor,
  });
}