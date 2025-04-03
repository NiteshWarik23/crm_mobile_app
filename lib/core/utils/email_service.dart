import 'package:crm_mobile_app/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MailService {
  static Future<void> sendEmail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
      if (email.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Email ID is empty.")),
      );
      return;
    }
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text("Unable to open email app")),
      );
    }
  }
}
