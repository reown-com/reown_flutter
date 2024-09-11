import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:reown_core/reown_core.dart';

enum PlatformType {
  mobile,
  desktop,
  web,
  unknown,
}

enum PlatformExact {
  ios,
  android,
  web,
  macos,
  windows,
  linux,
  unknown;

  PlatformType get pType {
    switch (this) {
      case ios:
      case android:
        return PlatformType.mobile;
      case macos:
      case windows:
      case linux:
        return PlatformType.desktop;
      case web:
        return PlatformType.web;
      default:
        return PlatformType.unknown;
    }
  }

  static PlatformExact fromName(String name) {
    return PlatformExact.values.firstWhereOrNull((e) {
          return e.name.toLowerCase() == name.toLowerCase();
        }) ??
        PlatformExact.unknown;
  }
}

class PlatformUtils {
  //
  static PlatformExact getPlatformExact() {
    final name = ReownCoreUtils.getId();
    return PlatformExact.fromName(name);
  }

  static PlatformType getPlatformType() {
    final name = ReownCoreUtils.getId();
    final platform = PlatformExact.fromName(name);
    return platform.pType;
  }

  static bool canDetectInstalledApps() {
    return getPlatformType() == PlatformType.mobile;
  }

  static bool isBottomSheet() {
    return getPlatformType() == PlatformType.mobile;
  }

  static bool isLongBottomSheet(Orientation orientation) {
    return getPlatformType() == PlatformType.mobile &&
        orientation == Orientation.landscape;
  }

  static bool isMobileWidth(double width) {
    return width <= 500.0;
  }

  static bool isTablet(BuildContext context) {
    final mqData = MediaQueryData.fromView(View.of(context));
    return mqData.size.shortestSide < 600 ? false : true;
  }
}
