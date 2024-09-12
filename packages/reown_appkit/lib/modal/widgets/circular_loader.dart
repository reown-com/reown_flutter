import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class CircularLoader extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  final EdgeInsetsGeometry? padding;
  const CircularLoader({
    super.key,
    this.size,
    this.strokeWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Container(
      padding: padding ?? const EdgeInsets.all(0.0),
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: themeColors.accent100,
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
