import 'package:crm_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> openWhatsApp(
      {required String phoneNumber, String? message}) async {
    if (phoneNumber.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Phone number is empty.")),
      );
      return;
    }

    final Uri whatsappUri = Uri.parse(
        "https://wa.me/+91$phoneNumber?text=${Uri.encodeComponent(message ?? '')}");

    // Check if the device can open WhatsApp
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
            content: Text("WhatsApp is not installed on this device.")),
      );
    }
  }
}
