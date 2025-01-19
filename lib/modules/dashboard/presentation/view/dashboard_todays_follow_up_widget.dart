import 'package:flutter/material.dart';

class TodaysFollowUpWidget extends StatelessWidget {
  const TodaysFollowUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Follow Up',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Flexible(
            flex: 0,
            child: ListView.builder(
              itemCount: 3, // Limit to 3 items
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Prevent the ListView from scrolling independently
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.0), // Border color and width
                      borderRadius:
                          BorderRadius.circular(8.0), // Optional: rounded corners
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      title: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          spacing: 20.0,
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/200'), // Replace with actual image URL
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Name ${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Campaign Name ${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Icon(Icons.more_vert),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 8.0,right: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 5.0,
                          children: [
                            Text(
                              'Time: 5:30 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            // AssetImage(
                            //     'assets/icons/instagram.svg'), // Replace with actual SVG path
                            // SvgPicture.asset(
                            //     'assets/icons/facebook.svg'), // Replace with actual SVG path
                            Row(
                              spacing: 10.0,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    onPressed: () {},
                                    backgroundColor: Colors.yellow,
                                    mini: true,
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    onPressed: () {},
                                    backgroundColor: Colors.yellow,
                                    mini: true,
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    onPressed: () {},
                                    backgroundColor: Colors.yellow,
                                    mini: true,
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
