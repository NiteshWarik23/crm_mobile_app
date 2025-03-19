import 'package:crm_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsService {
  static Future<void> sendSms(String phoneNumber, {String message = ""}) async {

     if (phoneNumber.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Phone number is empty.")),
      );
      return;
    }
    
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {"body": message},
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
       scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
            content: Text("SMS is not supported on this device.")),
      );
      
    }
  }
}
