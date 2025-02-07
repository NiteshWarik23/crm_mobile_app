import 'package:crm_mobile_app/modules/profile/presentation/view/widgets/profile_header_view_widget.dart';
import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.0,
        children: [
          Text(
            "Setting",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          TitlewithActionWidget(
            title: "Notification",
            action: () {},
          ),
          TitleAndValueWidget(
              title: "Language and Region", value: "English (United States)"),
          TitlewithActionWidget(
            title: "Integration Management",
            action: () {},
          )
        ],
      ),
    );
  }
}
