// ignore_for_file: always_put_required_named_parameters_first

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.size,
    required this.isLineThrough,
  });

  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double size;
  final bool isLineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: size,
        fontFamily: GoogleFonts.inter().fontFamily,
        decoration:
            isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
