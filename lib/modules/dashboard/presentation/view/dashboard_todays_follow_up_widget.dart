// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
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
                          children: [
                            Row(
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
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Campaign Name ${index + 1}',
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 8.0, right: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 5.0,
                                children: [
                                  Text(
                                    'Time: 5:30 PM',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.greyshade500,
                                    ),
                                  ),
                                  // AssetImage(
                                  //     'assets/icons/instagram.svg'), // Replace with actual SVG path
                                  // SvgPicture.asset(
                                  //     'assets/icons/facebook.svg'), // Replace with actual SVG path
                                  Row(
                                    spacing: 10.0,
                                    children: [
                                      CommonFloatingButtonWidget(
                                        iconPath: "assets/icons/whatsapp.png",
                                      ),
                                      CommonFloatingButtonWidget(
                                        iconPath: "assets/icons/whatsapp.png",
                                      ),
                                      CommonFloatingButtonWidget(
                                        iconPath: "assets/icons/instagram.png",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // trailing: Padding(
                      //   padding: const EdgeInsets.only(right: 8.0,bottom: 10),
                      //   child: Icon(Icons.more_vert),
                      // ),
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

class CommonFloatingButtonWidget extends StatelessWidget {
  const CommonFloatingButtonWidget({
    super.key,
    required this.iconPath,
  });
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: GestureDetector(
        onTap: () {
          // Action when button is tapped
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.yellowshade,
            shape: BoxShape.circle, // Makes it circular
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              height: 13,
              width: 13,

              //filterQuality: FilterQuality.high,
              //color: Colors.black,
            ),
            //Icon(Icons.add, size: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
