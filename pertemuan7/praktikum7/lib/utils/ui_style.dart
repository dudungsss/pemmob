import 'package:flutter/material.dart';

class UiStyle {
  UiStyle._();

  static bool gelap(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color hijau(BuildContext context) {
    return gelap(context) ? const Color(0xFF72D9A2) : const Color(0xFF228A58);
  }

  static Color merah(BuildContext context) {
    return gelap(context) ? const Color(0xFFFF8983) : const Color(0xFFE64C49);
  }

  static Color garis(BuildContext context) {
    return Theme.of(context).colorScheme.outlineVariant.withOpacity(0.50);
  }

  static Color permukaan(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }
}
