import 'package:flutter/material.dart';
import 'page.dart'; // Make sure this import points to where FlutterFormPage is defined.

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
    Map<String, String>? initialData, // Ensure this is included in the parameter list.
  }) {
    if (initialData != null) {
      for (var page in pages) {
        // Ensure FlutterFormPage is designed to accept and use initialData.
        if (initialData.containsKey(page.heading)) {
          page.initialData = initialData[page.heading];
        }
      }
    }
  }
}

// Ensure the FlutterFormPage class is designed to handle initialData. This might involve adding an initialData property to the class and adjusting its widgets to use this data.
