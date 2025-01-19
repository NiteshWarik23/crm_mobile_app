// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crm_mobile_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LeadViewWidget extends StatelessWidget {
  const LeadViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lead View',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25,
                width: 25,
                child: FloatingActionButton(
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
          SizedBox(height: 20),
          // Card with Title and Number Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardWidget(
                title: 'Leads Received',
                value: '250',
              ),
              CardWidget(
                title: 'Leads Closed',
                value: '25',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        Container(
          height: 90,
          width: MediaQuery.sizeOf(context).width / 2.5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.greenshade01,
          ),
        ),
      ],
    );
  }
}
