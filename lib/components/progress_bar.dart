import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'constants.dart';

class CustomProgressIndicatorWidget extends StatefulWidget{
  const CustomProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProgressIndicatorState();

}

class ProgressIndicatorState extends State<CustomProgressIndicatorWidget> {

    double _startAngle = 0;
    final double _endAngle = 100;

   Timer? _loadTimer;

   final List<double> _vals = [-120,-60,0,60,120,180];
   int _count = 4;

   @override
  void initState(){
     setState(() {
       _startAngle = _vals[_count];
     });
     super.initState();
     var duration = const Duration(milliseconds: 250);
     _loadTimer = Timer.periodic(duration, (timer) {
       setState((){
         _count = _count+1 >= _vals.length ? 0 : _count+1;
         _startAngle = _vals[_count];
       });
     });
   }

   @override
   void deactivate() {
     _loadTimer?.cancel();
     super.deactivate();
   }


  @override
  Widget build(BuildContext context) {
    const buttonSize = 60.0;
    const borderWidth = 5.0;

    return Stack(
      children: [
        Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: borderWidth,
            ),
          ),
        ),
        SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: CustomPaint(
            painter: ProgressIndicatorPainter(
              width: borderWidth,
              startAngle: _startAngle.toInt(),
              sweepAngle: _endAngle.toInt(),
            ),
            child: Center(
              child: Container(
                width: buttonSize - 20.0,
                height: buttonSize - 20.0,
                decoration: const BoxDecoration(
                  color: lightOffWhite,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Image.asset('assets/images/greenleaf_logo.png',color: kPrimaryColor,fit: BoxFit.fill,height: 30,width: 30,),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  const ProgressIndicatorPainter({
    required this.width,
    required this.startAngle,
    required this.sweepAngle,
  }) : super();

  final double width;
  final int startAngle;
  final int sweepAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kPrimaryColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final startAngleRad = startAngle * (math.pi / 180.0);
    final sweepAngleRad = sweepAngle * (math.pi / 180.0);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (width / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleRad,
      sweepAngleRad,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}