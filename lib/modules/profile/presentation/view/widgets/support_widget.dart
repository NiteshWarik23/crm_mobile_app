import 'package:crm_mobile_app/modules/profile/presentation/view/widgets/profile_header_view_widget.dart';
import 'package:flutter/material.dart';

class SupportWidget extends StatelessWidget {
  const SupportWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15.0,
        left: 15.0,
        top: 30.0,
        bottom: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.0,
        children: [
          Text(
            "Support",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          TitlewithActionWidget(
            title: "Help Center",
            action: () {},
          ),
          TitlewithActionWidget(
            title: "Contact Support",
            action: () {},
          ),
          TitlewithActionWidget(
            title: "Logout",
            action: () {},
          )
        ],
      ),
    );
  }
}
