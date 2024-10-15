import 'package:flutter/widgets.dart';
import 'package:flutter_placeholder/src/widget/placeholder_ex.dart';

enum _PlaceholderImageMode {
  scaffold,
  gradient,
  checkerboard,
}

class PlaceholderImage extends PlaceholderEx {
  final Color? primary;
  final Color? secondary;
  final Size? size;
  final String? caption;
  final TextStyle? captionStyle;

  final _PlaceholderImageMode _mode;

  const PlaceholderImage.scaffold({
    super.key,
    this.primary,
    this.secondary,
    this.size,
    this.caption,
    this.captionStyle,
  }) : _mode = _PlaceholderImageMode.scaffold;

  const PlaceholderImage.gradient({
    super.key,
    this.primary,
    this.secondary,
    this.size,
    this.caption,
    this.captionStyle,
  }) : _mode = _PlaceholderImageMode.gradient;

  const PlaceholderImage.checkerboard({
    super.key,
    this.primary,
    this.secondary,
    this.size,
    this.caption,
    this.captionStyle,
  }) : _mode = _PlaceholderImageMode.checkerboard;

  @override
  Widget build(BuildContext context) {
    final captionStyleWithColor = captionStyle == null
        ? null
        : captionStyle!.color == null
            ? captionStyle!.copyWith(color: const Color(0xFFFFFFFF))
            : captionStyle;
    final captionTextStyle =
        DefaultTextStyle.of(context).style.merge(captionStyleWithColor);

    final boxSize = Size(
      size?.width ?? double.infinity,
      size?.height ?? double.infinity,
    );

    Widget child;
    if (_mode == _PlaceholderImageMode.gradient) {
      child = _PlaceholderImageGradientInternal(
        primary: primary ?? const Color(0xFFCCCCCC),
        secondary: secondary ?? const Color(0xFF444444),
        size: boxSize,
      );
    } else {
      final painter = switch (_mode) {
        _PlaceholderImageMode.scaffold => _PlaceholderImageScaffold(
            primary: primary ?? const Color(0xFFFF0000),
            secondary: secondary ?? const Color(0xFFBBBBBB),
          ),
        _PlaceholderImageMode.checkerboard => _PlaceholderImageCheckerboard(
            primary: primary ?? const Color(0xFFBBBBBB),
            secondary: secondary ?? const Color(0xFF777777),
          ),
        _ => throw UnimplementedError(),
      };

      child = CustomPaint(painter: painter);
    }

    formatNumber(double x, [int maxDecimals = 2]) {
      final str = x.toStringAsFixed(maxDecimals);
      for (int idx = str.length - 1; idx >= 0; idx--) {
        if (str[idx] == '0') continue;
        if (str[idx] == '.') return str.substring(0, idx);
        return str.substring(0, idx + 1);
      }
      return '0';
    }

    return SizedBox.fromSize(
      size: boxSize,
      child: LayoutBuilder(builder: (context, constraints) {
        final captionText = caption ??
            'Size: ${formatNumber(constraints.biggest.width)}px x ${formatNumber(constraints.biggest.height)}px';

        return Stack(
          children: [
            Positioned.fill(child: child),
            Positioned.fill(
              child: Center(
                child: Text(
                  captionText,
                  style: captionTextStyle,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _PlaceholderImageScaffold extends CustomPainter {
  static const _strokeWidth = 8.0;

  final Color primary;
  final Color secondary;

  _PlaceholderImageScaffold({
    required this.primary,
    required this.secondary,
  });

  Rect _offsetRectBy(Rect rect, double dist) {
    final newOffset = Offset(rect.topLeft.dx + dist, rect.topLeft.dy + dist);
    final newSize = Size(rect.size.width - (newOffset.dx * 2),
        rect.size.height - (newOffset.dy * 2));

    return newOffset & newSize;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final fillPaint = Paint()
      ..color = secondary
      ..style = PaintingStyle.fill;

    final fillRect = Offset.zero & size;

    canvas.drawRect(fillRect, fillPaint);

    final strokeRect = _offsetRectBy(fillRect, _strokeWidth / 2);

    canvas.drawRect(strokeRect, strokePaint);
    canvas.drawLine(strokeRect.topLeft, strokeRect.bottomRight, strokePaint);
    canvas.drawLine(strokeRect.bottomLeft, strokeRect.topRight, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _PlaceholderImageScaffold oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}

class _PlaceholderImageCheckerboard extends CustomPainter {
  static const _boxDimension = 24.0;

  final Color primary;
  final Color secondary;

  _PlaceholderImageCheckerboard({
    required this.primary,
    required this.secondary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final primaryPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.fill;
    final secondaryPaint = Paint()
      ..color = secondary
      ..style = PaintingStyle.fill;

    final maxX = (size.width / _boxDimension).toInt();
    final maxY = (size.height / _boxDimension).toInt();

    Rect rect;
    double left, top, right, bottom;
    for (int y = 0; y <= maxY; y++) {
      for (int x = 0; x <= maxX; x++) {
        left = x * _boxDimension;
        top = y * _boxDimension;
        right = left + _boxDimension;
        bottom = top + _boxDimension;

        if (right > size.width) right = size.width;
        if (bottom > size.height) bottom = size.height;

        rect = Rect.fromLTRB(left, top, right, bottom);

        if ((x + y) % 2 == 0) {
          canvas.drawRect(rect, primaryPaint);
        } else {
          canvas.drawRect(rect, secondaryPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PlaceholderImageCheckerboard oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}

class _PlaceholderImageGradientInternal extends StatelessWidget {
  final Color primary;
  final Color secondary;
  final Size size;

  const _PlaceholderImageGradientInternal({
    required this.primary,
    required this.secondary,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, secondary],
            stops: const [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
