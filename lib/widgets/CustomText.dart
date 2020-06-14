import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final Color color;
  final double size;
  final Alignment alignment;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final bool isBold;

  CustomText({
    @required this.text,
    @required this.size,
    this.color = Colors.black,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.center,
    this.textDecoration = TextDecoration.none,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(7.5),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Varela',
          decoration: textDecoration,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: textAlign,
      ),
    );
  }
}