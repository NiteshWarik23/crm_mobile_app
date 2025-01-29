import 'package:flutter/material.dart';

class ChannelPerformanceWidget extends StatelessWidget {
  const ChannelPerformanceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text("Channel Performance"),
        Text(
          "CTR",
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "1.56%",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Last 30 Days ',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: '+12%',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
