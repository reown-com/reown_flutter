import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            final screenWidth = constraints.maxWidth;
            final isPortrait = orientation == Orientation.portrait;
            final realMaxHeight =
                isPortrait ? screenHeight * 0.75 : screenHeight;
            final realMinHeight = isPortrait ? 0.0 : realMaxHeight;

            final data = MediaQueryData.fromView(View.of(context));
            final isTabletSize = data.size.shortestSide < 600 ? false : true;
            final maxWidth = isTabletSize ? 360.0 : data.size.shortestSide;
            final maxHeight = isTabletSize ? 600.0 : realMaxHeight;

            return ResponsiveData(
              maxHeight: maxHeight,
              minHeight: realMinHeight,
              maxWidth: maxWidth,
              minWidth: screenWidth,
              orientation: orientation,
              child: child,
            );
          },
        );
      },
    );
  }
}

class ResponsiveData extends InheritedWidget {
  const ResponsiveData({
    super.key,
    required this.maxHeight,
    required this.minHeight,
    required this.maxWidth,
    required this.minWidth,
    required this.orientation,
    required super.child,
  });
  final double maxHeight, minHeight, maxWidth, minWidth;
  final Orientation orientation;

  static ResponsiveData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveData>();
  }

  static ResponsiveData of(BuildContext context) {
    final ResponsiveData? result = maybeOf(context);
    assert(result != null, 'No ResponsiveContainer found in context');
    return result!;
  }

  static double maxHeightOf(BuildContext context) {
    final container = maybeOf(context);
    return min(
      (container?.maxHeight ?? MediaQuery.of(context).size.height),
      900,
    );
  }

  static double minHeightOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.minHeight ?? MediaQuery.of(context).size.height);
  }

  static double maxWidthOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.maxWidth ?? MediaQuery.of(context).size.width);
  }

  static double minWidthOf(BuildContext context) {
    final container = maybeOf(context);
    return (container?.minWidth ?? MediaQuery.of(context).size.width);
  }

  static double paddingBottomOf(BuildContext context) {
    return max(MediaQuery.of(context).viewInsets.bottom, kPadding6);
  }

  static bool isKeyboardShown(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static bool isPortrait(BuildContext context) {
    final container = maybeOf(context);
    return container?.orientation.isPortrait ?? false;
  }

  static int gridAxisCountOf(BuildContext context) {
    final isPortraitMode = isPortrait(context);
    final maxWidth = maxWidthOf(context);
    final maxExtent =
        (kGridAxisCountPW * kGridItemWidth) + (kPadding12 * 2) + kPadding16;
    if (maxWidth > maxExtent) {
      return isPortraitMode ? kGridAxisCountPW : kGridAxisCountLW;
    }
    return isPortraitMode ? kGridAxisCountP : kGridAxisCountL;
  }

  static Size gridItemSzieOf(BuildContext context) {
    return Size(kGridItemWidth, kGridItemHeight);
  }

  @override
  bool updateShouldNotify(ResponsiveData oldWidget) => true;
}

extension on Orientation {
  bool get isPortrait => this == Orientation.portrait;
}
