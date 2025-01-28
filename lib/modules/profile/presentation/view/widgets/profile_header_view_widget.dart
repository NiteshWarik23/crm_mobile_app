// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileHeaderViewWidget extends StatelessWidget {
  const ProfileHeaderViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Center(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/image.png"),
                  ),
                ),
                Text("Mitchel Cameron")
              ],
            ),
          ),
          TitleAndValueWidget(
              title: "Email", value: "mitchel.cameron@gmail.com"),
          TitleAndValueWidget(title: "Phone", value: "+1 123 456 7890"),
          TitlewithActionWidget(
            title: "Change Password",
            action: () {},
          )
        ],
      ),
    );
  }
}

class TitlewithActionWidget extends StatelessWidget {
  String title;
  VoidCallback action;
  TitlewithActionWidget({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        GestureDetector(
          onTap: action,
          child: Icon(Icons.arrow_forward_rounded)),
       
      ],
    );
  }
}

class TitleAndValueWidget extends StatelessWidget {
  String title;
  String value;
  TitleAndValueWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        Text(title),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}


