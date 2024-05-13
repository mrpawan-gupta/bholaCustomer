import "package:flutter/material.dart";
import "package:marquee/marquee.dart";

class MaybeMarqueeText extends StatelessWidget {
  const MaybeMarqueeText({
    required this.text,
    required this.style,
    required this.alignment,
    super.key,
  });
  final String text;
  final TextStyle style;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _fontSize(context: context),
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return _overflowing(context: context, maxWidth: constraints.maxWidth)
              ? Marquee(
                  text: text,
                  style: style,
                  blankSpace: constraints.maxWidth / 3,
                  pauseAfterRound: const Duration(seconds: 3),
                )
              : Align(
                  alignment: alignment,
                  child: Text(
                    text,
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                );
        },
      ),
    );
  }

  bool _overflowing({required BuildContext context, required double maxWidth}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final bool didExceedMaxLines = textPainter.didExceedMaxLines;
    return didExceedMaxLines;
  }

  double _fontSize({required BuildContext context}) {
    final double fontSize = Text(text, style: style).style?.fontSize ??
        DefaultTextStyle.of(context).style.fontSize ??
        0.0;
    final double height = Text(text, style: style).style?.height ??
        DefaultTextStyle.of(context).style.height ??
        0.0;

    final double result = fontSize * height;
    return result;
  }
}
