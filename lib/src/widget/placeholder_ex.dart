library flutter_placeholder;

import 'package:flutter/widgets.dart';

import '../utility/lipsum/definibus.dart';
import 'text/lipsum.dart';
import 'text/shadow.dart';
import 'image/image.dart';

export 'text/lipsum.dart';

abstract class PlaceholderEx extends StatelessWidget {
  const PlaceholderEx({super.key});

  const factory PlaceholderEx.words(
    int lines, {
    Key? key,
    Definibus definibus,
    int? seed,
    bool startWithLorem,
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
  }) = LipsumText.words;

  const factory PlaceholderEx.linesOfText(
    int lines, {
    Key? key,
    Definibus definibus,
    int? seed,
    bool startWithLorem,
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
  }) = LipsumText.lines;

  const factory PlaceholderEx.paragraphs(
    int lines, {
    Key? key,
    Definibus definibus,
    int? seed,
    bool startWithLorem,
    int minSentencesPerParagraph,
    int maxSentencesPerParagraph,
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
  }) = LipsumText.paragraphs;

  const factory PlaceholderEx.shadowText({
    Key? key,
    int? words,
    Color? color,
    double? shadowHeight,
    double? lineSpacing,
    int? seed,
  }) = ShadowText.words;

  const factory PlaceholderEx.image({
    Key? key,
    Color? primary,
    Color? secondary,
    Size? size,
    String? caption,
    TextStyle? captionStyle,
  }) = PlaceholderImage.scaffold;

  const factory PlaceholderEx.imageGradient({
    Key? key,
    Color? primary,
    Color? secondary,
    Size? size,
    String? caption,
    TextStyle? captionStyle,
  }) = PlaceholderImage.gradient;

  const factory PlaceholderEx.imageCheckerboard({
    Key? key,
    Color? primary,
    Color? secondary,
    Size? size,
    String? caption,
    TextStyle? captionStyle,
  }) = PlaceholderImage.checkerboard;
}
