import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_placeholder/flutter_placeholder.dart';

final class ShadowText extends StatelessWidget {
  final int? words;
  final Color? color;
  final double? shadowHeight;
  final double? lineSpacing;
  final double? cornerRadius;
  final int? seed;

  const ShadowText.words({
    super.key,
    this.words,
    this.color,
    this.shadowHeight,
    this.lineSpacing,
    this.cornerRadius,
    this.seed,
  });

  @override
  Widget build(BuildContext context) {
    var wordGenerator = Lipsum().wordGenerator(random: Random(seed));
    var isFinite = false;

    if (words != null) {
      wordGenerator = wordGenerator.take(words!);
      isFinite = true;
    }

    return CustomPaint(
      painter: _ShadowTextPainter(
        wordGenerator: wordGenerator,
        isFinite: isFinite,
        color: color,
        shadowHeight: shadowHeight,
        lineSpacing: lineSpacing,
        cornerRadius: cornerRadius,
      ),
    );
  }
}

class _ShadowTextPainter extends CustomPainter {
  static final _whitespacePattern = RegExp(r'\s');
  static const _fontWidthToHeightRatio = 0.6;
  static const _lineHeightToSpacingRatio = 0.25;

  final Color color;
  final double shadowHeight;
  final double? lineSpacing;
  final double? cornerRadius;
  final Iterable<String> wordGenerator;
  final bool isFinite;

  const _ShadowTextPainter({
    required this.wordGenerator,
    required this.isFinite,
    Color? color,
    double? shadowHeight,
    this.cornerRadius,
    this.lineSpacing,
  })  : color = color ?? const Color(0xFFBBBBBB),
        shadowHeight = shadowHeight ?? 18;

  Iterable<String> _lettersOf(String str) sync* {
    for (final rune in str.runes) {
      yield String.fromCharCode(rune);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if ((size.width.isInfinite || size.height.isInfinite) && !isFinite) {
      throw StateError(
          'Indeterminitely generating word list in an unbounded space would result in an infinite loop. Either supply ShadowText with a finite word list or impose size constraints.');
    }

    final shadowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final charPixelWidth = shadowHeight * _fontWidthToHeightRatio;
    final calcLineSpacing =
        lineSpacing ?? shadowHeight * _lineHeightToSpacingRatio;

    final maxUnitWidth = (size.width / charPixelWidth).toInt();
    final maxLineHeight =
        (size.height / (shadowHeight + calcLineSpacing)).toInt() - 1;

    int unitWidth = 0;
    int lineIdx = 0;
    int spanIdx = 0;

    void drawBox() {
      final x = spanIdx * charPixelWidth;
      final y = lineIdx * shadowHeight + lineIdx * calcLineSpacing;
      final width = unitWidth * charPixelWidth;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, width, shadowHeight),
          Radius.circular(cornerRadius ?? (shadowHeight / 2)),
        ),
        shadowPaint,
      );
    }

    for (final word in wordGenerator) {
      for (final letter in _lettersOf(word)) {
        if (!_whitespacePattern.hasMatch(letter)) {
          unitWidth++;

          if ((unitWidth + spanIdx) < maxUnitWidth) continue;

          if (spanIdx > 0) {
            lineIdx++;
            spanIdx = 0;
            continue;
          }
        }
      }

      if (unitWidth > 0) drawBox();

      if (unitWidth == maxUnitWidth) {
        lineIdx++;
        spanIdx = 0;
      } else if (unitWidth > 0) {
        spanIdx += unitWidth + 1;
      }

      if (lineIdx >= maxLineHeight) break;

      unitWidth = 0;
    }

    if (unitWidth > 0 && lineIdx < maxLineHeight) drawBox();
  }

  @override
  bool shouldRepaint(covariant _ShadowTextPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.wordGenerator != wordGenerator ||
        oldDelegate.lineSpacing != lineSpacing ||
        oldDelegate.shadowHeight != shadowHeight;
  }
}
