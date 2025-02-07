import 'package:flutter/material.dart';

class ChatInboxScreen extends StatefulWidget {
  const ChatInboxScreen({super.key});

  @override
  State<ChatInboxScreen> createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  final List<Map<String, String>> messages = [
    {
      "name": "Allen Keller",
      "platform": "Linked In",
      "message": "The Meeting Is Cancelled Due To Some...",
      "time": "2:50 PM",
    },
    {
      "name": "Allen Keller",
      "platform": "Instagram",
      "message": "The Meeting Is Cancelled Due To Some...",
      "time": "2:50 PM",
    },
    {
      "name": "Allen Keller",
      "platform": "Facebook",
      "message": "The Meeting Is Cancelled Due To Some...",
      "time": "2:50 PM",
    },
    {
      "name": "Allen Keller",
      "platform": "Google",
      "message": "The Meeting Is Cancelled Due To Some...",
      "time": "2:50 PM",
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredMessages = messages.where((message) {
      return message["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          message["platform"]!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_sharp, color: Colors.green),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Inbox",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton("All Messages"),
                  const SizedBox(width: 10),
                  _buildTabButton("Marked Important"),
                  const SizedBox(width: 10),
                  _buildTabButton("Unread"),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        message["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message["platform"]!),
                          const SizedBox(height: 4),
                          Text(
                            message["message"]!,
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: Text(
                        message["time"]!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTabButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

