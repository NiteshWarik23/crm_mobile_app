import 'package:flutter/material.dart';

class ContactProfileScreen extends StatelessWidget {
  const ContactProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, size: 30, color: Colors.grey[200]),
                        ),
                const SizedBox(height: 10),
                const Text(
                  'Anna Smith',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Work Email',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'annasmith12@gmail.com',
                      style:
                      TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Number',
                      style:
                      TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const Text(
                      '0987654321',
                      style:
                      TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(Icons.phone),
                _buildIconButton(Icons.chat),
                _buildIconButton(Icons.assistant_direction),
                _buildIconButton(Icons.email),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Campaign Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: _InfoRow(label: 'Campaign Name', value: 'Name Of Campaign'),
                ),
                  Divider(
                  color: Colors.grey[200],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: _InfoRow(label: 'Channel', value: 'Instagram / Facebook'),
                ),
                Divider(
                  color: Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildTaskButton(Icons.note_add, 'Add Note',Icons.add),
                const SizedBox(height: 10),
                _buildTaskButton(Icons.update, 'Update Status',Icons.add),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber[100],
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: Colors.black, size: 30),
    );
  }

  Widget _buildTaskButton(IconData icon, String label,IconData icon2) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 10),
        Text(label),
        Spacer(),
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
          child:  Icon(
            icon2, // Search icon
            color: Colors.black, // Icon color
            size: 20, // Icon size
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.4, // Fixed width for the label to ensure alignment
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


