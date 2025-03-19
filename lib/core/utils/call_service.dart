import 'package:crm_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallService {
  static Future<void> makePhoneCall(String phoneNumber) async {
    if(phoneNumber.isEmpty){
       scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Phone number is empty.")),
      );
      return;
    }

    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    // Check if the device can make a call
    bool canCall = await canLaunchUrl(launchUri);

    if (canCall) {
      await launchUrl(launchUri);
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Calling is not supported on this device.")),
      );
    }
  }
}
