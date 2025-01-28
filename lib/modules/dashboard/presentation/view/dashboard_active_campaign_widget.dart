// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ActiveCampaignWidget extends StatelessWidget {
  const ActiveCampaignWidget({super.key});

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
            'Active Campaign',
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
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.0), // Border color and width
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: rounded corners
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(
                          spacing: 8,
                          children: [
                            Row(
                              spacing: 20.0,
                              children: [
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
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Campaign Progress',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                                ),
                                GradientLinearProgressIndicator(
                                  value: 0.7,
                                ),
                              ],
                            )
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


class GradientLinearProgressIndicator extends StatelessWidget {
  final double value; // Progress value (0.0 to 1.0)

  const GradientLinearProgressIndicator({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.transparent, // Background color
            borderRadius: BorderRadius.circular(5),
             border: Border.all(
              color: Colors.white,
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * value,
          height: 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color(0xFFFDDA81),
                Color(0XFF009963),
                // Color(0xff1f005c),
                // Color(0xff5b0060),
                // Color(0xff870160),
                // Color(0xffac255e),
                // Color(0xffca485c),
                // Color(0xffe16b5c),
                // Color(0xfff39060),
                // Color(0xffffb56b),
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
          ),
        ),
      ],
    );
  }
}
