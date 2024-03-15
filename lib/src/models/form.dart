import 'package:flutter/material.dart';

import 'page.dart';

class FlutterFormData {
  final String name;
  final Color? themeColor;
  final String? logo;
  final bool showLogo;
  final Color backgroundColor;
  final Duration pageTransitionDuration;
  List<FlutterFormPage> pages;
  final Function(FlutterFormPage page) onPageEdited;
  final Function(List<FlutterFormPage> pages) onFormSubmitted;

  FlutterFormData({
    required this.name,
    required this.pages,
    this.themeColor,
    this.logo,
    this.backgroundColor = Colors.white,
    this.pageTransitionDuration = const Duration(seconds: 2),
    this.showLogo = true,
    required this.onPageEdited,
    required this.onFormSubmitted,
    Map<String, String>? initialData,
  }) {
    // Propagate initial data to each page
    if (initialData != null) {
      for (var page in pages) {
        Map<String, String> pageInitialData = {}; // Explicitly declare the type
        // Assuming you populate pageInitialData based on some logic
        page.updateInitialData(pageInitialData);
      }
    }
  }
}
