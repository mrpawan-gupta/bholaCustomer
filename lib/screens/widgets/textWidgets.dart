import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class TextWidget extends StatelessWidget {

  TextWidget(
      {required this.text, required this.color, required this.fontWeight,
        required this.size, required this.isLineThrough, super.key,});
  String text;
  FontWeight fontWeight;
  Color color;
  double size;
  bool isLineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: size,
        fontFamily: GoogleFonts.lato().fontFamily,
        decoration:
        isLineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
