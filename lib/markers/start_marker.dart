 
import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    final blackPaint = Paint()
                      ..color = Colors.black;

    final whitePaint = Paint()
                      ..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;
    
    //circulo negro
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height -circleBlackRadius),
      circleBlackRadius,
      blackPaint);

    //circulo blanco
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height -circleBlackRadius),
      circleWhiteRadius,
      whitePaint);

    //dibujar una caja blanca
    final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width -10, 20 );
    path.lineTo(size.width -10, 100 );
    path.lineTo(40, 100 ); 

    //sombra
    canvas.drawShadow(path, Colors.black, 10, false);
    //caja
    canvas.drawPath(path, whitePaint);

    // Caja negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint);

    //Textos
    //Minutos
    final textSpan = TextSpan(
      style: const TextStyle( color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '55'
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr, //left to right
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesPainter.paint( canvas, const Offset( 40, 35 ));

    //palabra Min
    final minutesText = TextSpan(
      style: const TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
      text: 'Min'
    );

    final minutesMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr, //left to right
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesMinPainter.paint( canvas, const Offset( 40, 68 ));
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}