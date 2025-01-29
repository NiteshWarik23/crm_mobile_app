// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crm_mobile_app/core/utils/app_colors.dart';

class AppIntegrationWidget extends StatelessWidget {
  const AppIntegrationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "App Integration",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 25,
                width: 25,
                child: FloatingActionButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.greyshade500),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  mini: true,
                  child: Icon(Icons.add, color: Colors.black,size: 18,),
                ),
              ),
            ],
          ),
          IntegrationWidget(
            title: "Google",
            status: "Connected",
            connectionStatus: "Connect",
            action: () {},
          ),
          IntegrationWidget(
            title: "Instagram",
            status: "Not Connected",
            connectionStatus: "Disconnect",
            action: () {},
          ),
          IntegrationWidget(
            title: "Zoom",
            status: "Connected",
            connectionStatus: "Connect",
            action: () {},
          ),
          IntegrationWidget(
            title: "Whatsapp",
            status: "Connected",
            connectionStatus: "Connect",
            action: () {},
          ),
          IntegrationWidget(
            title: "LinkedIn",
            status: "Connected",
            connectionStatus: "Connect",
            action: () {},
          ),
        ],
      ),
    );
  }
}

class IntegrationWidget extends StatelessWidget {
  String title;
  String status;
  String connectionStatus;
  VoidCallback action;
  IntegrationWidget({
    super.key,
    required this.title,
    required this.status,
    required this.connectionStatus,
    required this.action,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            Text(
              status,
              style: TextStyle(
                  fontSize: 10,
                  color: AppColors.greyshade500,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            minimumSize: Size(80.0, 30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: AppColors.greyshade500,
              ),
            ),
          ),
          child: Text(
            connectionStatus,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
