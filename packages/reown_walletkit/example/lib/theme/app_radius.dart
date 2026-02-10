import 'package:flutter/material.dart';

abstract final class AppRadius {
  // Figma BorderRadius scale
  static const double r0 = 0.0;
  static const double r1 = 4.0;
  static const double r2 = 8.0;
  static const double r3 = 12.0;
  static const double r4 = 16.0;
  static const double r5 = 20.0;
  static const double r6 = 24.0;
  static const double r7 = 28.0;
  static const double r8 = 32.0;
  static const double r9 = 36.0;
  static const double r10 = 40.0;
  static const double r11 = 48.0;
  static const double r12 = 56.0;
  static const double r13 = 64.0;
  static const double full = 9999.0;

  // Named aliases for backward compatibility
  static const double xs = r1;
  static const double sm = r2;
  static const double md = r4;
  static const double lg = r5;
  static const double xl = r8;
  static const double xxl = r11;

  // Convenience BorderRadius helpers
  static final BorderRadius borderRadiusSm = BorderRadius.circular(sm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(md);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(lg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(xl);
  static final BorderRadius borderRadiusXxl = BorderRadius.circular(xxl);
}
