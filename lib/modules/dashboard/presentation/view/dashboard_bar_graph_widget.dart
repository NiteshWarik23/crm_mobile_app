// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui' as ui;

// class CampaignBarChart extends StatelessWidget {
//   final List<CampaignData> data = [
//     CampaignData("Facebook", 50, Colors.grey.shade100, AssetImage( "assets/icons/facebook.png")),
//     CampaignData("Instagram", 70, Colors.white,AssetImage( "assets/icons/instagram.png")),
//     CampaignData("LinkedIn", 40, Colors.white,AssetImage("assets/icons/linkedin.png") ),
//     CampaignData("Pinterest", 30, Colors.white,AssetImage( "assets/icons/pinterest.png")),
//     CampaignData("WhatsApp", 60, Colors.white,AssetImage( "assets/icons/whatsapp.png")),
//     CampaignData("Snapchat", 25, Colors.white,AssetImage("assets/icons/snapchat.png") ),
//     CampaignData("Twitter", 45, Colors.white,AssetImage("assets/icons/twitter.png") ),
//   ];

//   CampaignBarChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: CustomPaint(
//         painter: BarChartPainter(data),
//       ),
//     );
//   }
// }

// class CampaignData {
//   final String platform;
//   final int count;
//   final Color color;
//   final AssetImage logoPath;

//   CampaignData(this.platform, this.count, this.color, this.logoPath);
// }

// class BarChartPainter extends CustomPainter {
//   final List<CampaignData> data;
//   final double barWidth = 40.0;
//   final double spaceBetweenBars = 30.0;
//   final double bottomPadding = 80.0;
//   final double topPadding = 20.0;

//   BarChartPainter(this.data);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final double maxCount =
//         data.map((d) => d.count).reduce((a, b) => a > b ? a : b).toDouble();
//     final double chartHeight = size.height - bottomPadding - topPadding;
//     final double barSpacing =
//         (size.width - (data.length * barWidth)) / (data.length + 1);

//     final TextPainter textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: ui.TextDirection.ltr,
//     );

//     final TextStyle countStyle = TextStyle(
//         fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
//     final TextStyle monthStyle = TextStyle(fontSize: 14, color: Colors.black);

//     String currentMonth = DateFormat.MMMM().format(DateTime.now());

//     for (int i = 0; i < data.length; i++) {
//       final campaign = data[i];

//       final double barHeight = (campaign.count / maxCount) * chartHeight;
//       final double xPosition = barSpacing + (i * (barWidth + barSpacing));
//       final double yPosition = size.height - bottomPadding - barHeight;

//       // Create gradient paint
//       final Paint gradientPaint = Paint()
//         ..shader = ui.Gradient.linear(
//           Offset(xPosition, yPosition), // Top of the bar
//           Offset(xPosition, yPosition + barHeight / 2), // Midpoint of the bar
//           [
//             Color.fromRGBO(0, 255, 0, 0.3), // Light green with alpha 0.3
//             Color.fromARGB(0, 255, 0, 0), // Fully transparent green
//           ], // Gradient colors
//         );

//       // Draw the gradient effect
//       Rect gradientRect =
//           Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight / 2);
//       canvas.drawRect(gradientRect, gradientPaint);

//       // Draw the solid color bar below the gradient
//       final Paint solidPaint = Paint()..color = campaign.color;
//       Rect solidRect = Rect.fromLTWH(
//           xPosition, yPosition + barHeight / 2, barWidth, barHeight / 2);
//       canvas.drawRect(solidRect, solidPaint);

//       // Draw the count above the bar
//       textPainter.text = TextSpan(text: "${campaign.count}", style: countStyle);
//       textPainter.layout();
//       textPainter.paint(
//           canvas,
//           Offset(
//               xPosition + (barWidth - textPainter.width) / 2, yPosition - 20));

//       // Load and draw the platform logo
//       final ui.PictureRecorder recorder = ui.PictureRecorder();
//       final Canvas tempCanvas = Canvas(recorder);
//       final paint = Paint();

//       final ImageStream stream = campaign.logoPath.resolve(ImageConfiguration());
//       stream.addListener(
//         ImageStreamListener((ImageInfo image, bool synchronousCall) {
//           tempCanvas.drawImage(image.image,
//               Offset(xPosition, size.height - bottomPadding + 10), paint);
//           canvas.drawPicture(recorder.endRecording());
//         }),
//       );

//       // Draw the month below the logo
//       textPainter.text = TextSpan(text: currentMonth, style: monthStyle);
//       textPainter.layout();
//       textPainter.paint(
//           canvas,
//           Offset(xPosition + (barWidth - textPainter.width) / 2,
//               size.height - 20));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class CampaignBarChart extends StatelessWidget {
  final List<CampaignData> data = [
    CampaignData("Facebook", 50, Colors.grey.shade100,
        AssetImage("assets/icons/facebook.png")),
    CampaignData("Instagram", 70, Colors.white,
        AssetImage("assets/icons/instagram.png")),
    CampaignData(
        "LinkedIn", 40, Colors.white, AssetImage("assets/icons/linkedin.png")),
    CampaignData("Pinterest", 30, Colors.white,
        AssetImage("assets/icons/pinterest.png")),
    CampaignData(
        "WhatsApp", 60, Colors.white, AssetImage("assets/icons/whatsapp.png")),
    CampaignData(
        "Snapchat", 25, Colors.white, AssetImage("assets/icons/snapchat.png")),
    CampaignData(
        "Twitter", 45, Colors.white, AssetImage("assets/icons/twitter.png")),
  ];

  CampaignBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: CustomPaint(
        painter: BarChartPainter(data),
      ),
    );
  }
}

class CampaignData {
  final String platform;
  final int count;
  final Color color;
  final AssetImage logoPath;

  CampaignData(this.platform, this.count, this.color, this.logoPath);
}

class BarChartPainter extends CustomPainter {
  final List<CampaignData> data;
  final double barWidth = 40.0;
  final double spaceBetweenBars = 30.0;
  final double bottomPadding = 80.0;
  final double topPadding = 20.0;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final double maxCount =
        data.map((d) => d.count).reduce((a, b) => a > b ? a : b).toDouble();
    final double chartHeight = size.height - bottomPadding - topPadding;
    final double barSpacing =
        (size.width - (data.length * barWidth)) / (data.length + 1);

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );

    final TextStyle countStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
    final TextStyle monthStyle = TextStyle(fontSize: 14, color: Colors.black);

    String currentMonth = DateFormat.MMM().format(DateTime.now());

    for (int i = 0; i < data.length; i++) {
      final campaign = data[i];

      final double barHeight = (campaign.count / maxCount) * chartHeight;
      final double xPosition = barSpacing + (i * (barWidth + barSpacing));
      final double yPosition = size.height - bottomPadding - barHeight;

      // 🔥 Light Grey Shadow
      final Paint shadowPaint = Paint()
        ..color = Colors.grey.withOpacity(0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);
      final RRect shadowRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
            xPosition - 2, yPosition - 2, barWidth + 4, barHeight + 4),
        Radius.circular(10),
      );
      canvas.drawRRect(shadowRect, shadowPaint);

      // 🔥 Dark Green Top Border
      final Paint topPaint = Paint()..color = Colors.green.shade900;
      final RRect topRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(xPosition, yPosition, barWidth, 4),
        Radius.circular(10),
      );
      canvas.drawRRect(topRect, topPaint);

      // 🔥 Create Gradient Paint
      final Paint gradientPaint = Paint()
        ..shader = ui.Gradient.linear(
          Offset(xPosition, yPosition),
          Offset(xPosition, yPosition + barHeight / 2),
          [
            Color.fromRGBO(0, 255, 0, 0), // Light green with alpha 0.3
            Color.fromRGBO(0, 255, 0, 0.3), // Light green with alpha 0.3
            Color.fromRGBO(0, 255, 0, 0), // Fully transparent green
          ],
          [0.0, 0.5, 1.0], // Color stops at 0%, 50%, and 100% respectively
        );

      // 🔥 Draw Rounded Gradient Bar
      final RRect gradientRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight / 2),
        Radius.circular(10),
      );
      canvas.drawRRect(gradientRect, gradientPaint);

      // 🔥 Draw Solid Color Bottom Half
      final Paint solidPaint = Paint()..color = campaign.color;
      final RRect solidRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
            xPosition, yPosition + barHeight / 2, barWidth, barHeight / 2),
        Radius.circular(0),
      );
      canvas.drawRRect(solidRect, solidPaint);

      // 🔥 Draw Count Above the Bar
      textPainter.text = TextSpan(text: "${campaign.count}", style: countStyle);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              xPosition + (barWidth - textPainter.width) / 2, yPosition - 20));

      // 🔥 Load and Draw Platform Logo
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas tempCanvas = Canvas(recorder);
      final paint = Paint();

      final ImageStream stream =
          campaign.logoPath.resolve(ImageConfiguration());
      stream.addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
          tempCanvas.drawImage(image.image,
              Offset(xPosition, size.height - bottomPadding + 10), paint);
          canvas.drawPicture(recorder.endRecording());
        }),
      );

      // 🔥 Draw Month Below the Logo
      textPainter.text = TextSpan(text: currentMonth, style: monthStyle);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(xPosition + (barWidth - textPainter.width) / 2,
              size.height - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
