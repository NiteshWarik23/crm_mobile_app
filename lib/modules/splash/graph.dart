import 'package:flutter/material.dart';

class SalesChartCustom extends StatelessWidget {
  final List<double> monthlySales;

  const SalesChartCustom({Key? key, required this.monthlySales})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // Makes it responsive
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 300),
          painter: SalesChartPainter(monthlySales),
        ),
      ),
    );
  }
}

class SalesChartPainter extends CustomPainter {
  final List<double> salesData;
  SalesChartPainter(this.salesData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final double maxY = salesData.reduce((a, b) => a > b ? a : b);
    final double minY = 0;
    final double graphHeight = size.height - 40;
    final double graphWidth = size.width - 40;
    final double xSpacing = graphWidth / (salesData.length - 1);

    Path path = Path();
    for (int i = 0; i < salesData.length; i++) {
      double x = i * xSpacing + 20;
      double y = size.height -
          ((salesData[i] - minY) / (maxY - minY) * graphHeight + 20);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(color: Colors.black, fontSize: 12);

    for (int i = 0; i < salesData.length; i++) {
      double x = i * xSpacing + 20;
      double y = size.height -
          ((salesData[i] - minY) / (maxY - minY) * graphHeight + 20);

      // Draw month labels
      textPainter.text = TextSpan(
        text: (i + 1).toString(),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 6, size.height - 20));

      // Draw data points
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



class SalesScreenCustom extends StatelessWidget {
  final List<double> salesData = [5, 8, 6, 10, 12, 14, 18, 16, 20, 25, 30, 35];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Sales Chart")),
      body: Center(child: SalesChartCustom(monthlySales: salesData)),
    );
  }
}
