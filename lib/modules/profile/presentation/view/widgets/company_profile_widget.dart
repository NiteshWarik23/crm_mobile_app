import 'package:crm_mobile_app/modules/profile/presentation/view/widgets/profile_header_view_widget.dart';
import 'package:flutter/material.dart';

class CompanyProfileWidget extends StatelessWidget {
  const CompanyProfileWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text("Company Profile"),
          TitleAndValueWidget(title: "Company Name", value: "Mitchel"),
          TitleAndValueWidget(
              title: "Company Email", value: "MitchelLtd@gmail.com"),
          TitlewithValueAndActionWidget(
            title: "Address",
            value: "123 Serenity Lane, Greenview Heights",
            action: () {},
          ),
          TitleAndValueWidget(title: "Subscription Plan", value: "Business"),
        ],
      ),
    );
  }
}

class TitlewithValueAndActionWidget extends StatelessWidget {
  String title;
  String value;
  VoidCallback action;
  TitlewithValueAndActionWidget({
    super.key,
    required this.title,
    required this.value,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        //  Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   spacing: 10,
        //   children: [
        //     Text(title),
        //     Text(
        //       value,
        //       style: TextStyle(fontSize: 12),
        //     ),
        //   ],
        // ),
        Text(title),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12),
          ),
        ),
        GestureDetector(
          onTap: action,
          child: Icon(Icons.arrow_forward_rounded)),
      ],
    );
  }
}
