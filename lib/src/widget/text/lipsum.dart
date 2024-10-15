import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../utility/lipsum/lipsum.dart';
import '../placeholder_ex.dart';

enum LipsumTextMode {
  words,
  lines,
  paragraphs,
}

final class LipsumText extends PlaceholderEx {
  final Definibus definibus;
  final LipsumTextMode mode;
  final int? seed;
  final bool? startWithLorem;

  // Word-specific properties
  final int? _wordCount;

  // Line-specific properties
  final int? _lineCount;

  // Paragraph-specific properties
  final int? _paragraphCount;
  final int? _paragraphMinSentencesPer;
  final int? _paragraphMaxSentencesPer;

  // Flutter passthrough properties
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const LipsumText._({
    super.key,
    required this.definibus,
    required this.mode,
    this.seed,
    this.startWithLorem,
    int? wordCount,
    int? lineCount,
    int? paragraphCount,
    int? paragraphMinSentencesPer,
    int? paragraphMaxSentencesPer,
    // Flutter passthrough properties
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    @Deprecated('Use textScaler instead. '
        'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
        'This feature was deprecated after v3.12.0-2.0.pre.')
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  })  : _wordCount = wordCount,
        _lineCount = lineCount,
        _paragraphCount = paragraphCount,
        _paragraphMinSentencesPer = paragraphMinSentencesPer,
        _paragraphMaxSentencesPer = paragraphMaxSentencesPer;

  const LipsumText.words(
    int words, {
    Key? key,
    Definibus definibus = Definibus.defaultDefinibus,
    int? seed,
    bool startWithLorem = false,
    // Flutter passthrough properties
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    @Deprecated('Use textScaler instead. '
        'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
        'This feature was deprecated after v3.12.0-2.0.pre.')
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) : this._(
          key: key,
          definibus: definibus,
          mode: LipsumTextMode.words,
          seed: seed,
          startWithLorem: startWithLorem,
          wordCount: words,
          //
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          // ignore: deprecated_member_use_from_same_package
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );

  const LipsumText.lines(
    int lines, {
    Key? key,
    Definibus definibus = Definibus.defaultDefinibus,
    int? seed,
    bool startWithLorem = false,
    // Flutter passthrough properties
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    @Deprecated('Use textScaler instead. '
        'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
        'This feature was deprecated after v3.12.0-2.0.pre.')
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) : this._(
          key: key,
          definibus: definibus,
          mode: LipsumTextMode.lines,
          seed: seed,
          startWithLorem: startWithLorem,
          lineCount: lines,
          //
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          // ignore: deprecated_member_use_from_same_package
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );

  const LipsumText.paragraphs(
    int paragraphs, {
    Key? key,
    Definibus definibus = Definibus.defaultDefinibus,
    int? seed,
    bool startWithLorem = false,
    int minSentencesPerParagraph = 3,
    int maxSentencesPerParagraph = 6,
    // Flutter passthrough properties
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    @Deprecated('Use textScaler instead. '
        'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
        'This feature was deprecated after v3.12.0-2.0.pre.')
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) : this._(
          key: key,
          definibus: definibus,
          mode: LipsumTextMode.paragraphs,
          seed: seed,
          startWithLorem: startWithLorem,
          paragraphCount: paragraphs,
          paragraphMinSentencesPer: minSentencesPerParagraph,
          paragraphMaxSentencesPer: maxSentencesPerParagraph,
          //
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          // ignore: deprecated_member_use_from_same_package
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );

  @override
  Widget build(BuildContext context) {
    final random = Random(seed);
    final lipsum = Lipsum(definibus: definibus);

    final text = switch (mode) {
      LipsumTextMode.words => lipsum
          .words(
            _wordCount!,
            random: random,
            startWithLorem: startWithLorem ?? false,
          )
          .join(' '),
      LipsumTextMode.lines => lipsum
          .lines(
            _lineCount!,
            random: random,
            startWithLorem: startWithLorem ?? false,
          )
          .join(' '),
      LipsumTextMode.paragraphs => lipsum
          .paragraphs(
            _paragraphCount!,
            random: random,
            startWithLorem: startWithLorem ?? false,
            minSentencesPer: _paragraphMinSentencesPer!,
            maxSentencesPer: _paragraphMaxSentencesPer!,
          )
          .join('\n\n'),
    };

    return Text(
      text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // ignore: deprecated_member_use
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
