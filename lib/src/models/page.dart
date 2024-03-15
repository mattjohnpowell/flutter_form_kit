import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/constants/enums.dart';
import 'package:flutter_form_kit/src/models/choice_option.dart';

class FlutterFormPage {
  final String heading;
  final String? description;
  final String? image;
  final AnswerType answerType;
  final ImageLayout? imageLayout;
  Map<String, String>? initialDataMap;
  TextEditingController controller;
  List<ChoiceOption>? options;
  List<ChoiceOption> selectedOptions = [];
  List<String> formField = [];

  FlutterFormPage({
    required this.heading,
    this.description,
    this.image,
    this.imageLayout,
    required this.answerType,
    this.options,
    this.initialDataMap, // Initial data map for form fields
  }) : controller = TextEditingController(text: initialDataMap?["default"] ?? "") { // Use a default key or specific field identifier
    // Initialize other properties or controllers if necessary
  }

  // Method to update initial data (for editing purposes)
  void updateInitialData(Map<String, String> newDataMap) {
    initialDataMap = newDataMap;
    // Update the controller with new initial data. Use appropriate key as needed.
    controller.text = initialDataMap?["default"] ?? "";
    // Update other fields or controllers if necessary
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'heading': heading,
      'answerType': answerType.toString(), // Assuming AnswerType is an enum
    };

    if (description != null) {
      json['description'] = description;
    }

    if (image != null) {
      json['image'] = image;
    }

    if (imageLayout != null) {
      json['imageLayout'] =
          imageLayout.toString(); // Assuming ImageLayout is an enum
    }

    // Additional logic as needed to include initialData and options in JSON.
    // You might need to convert initialDataMap to a list of strings or other format
    if (initialDataMap != null) {
      json['initialDataMap'] = initialDataMap;
    }
    

    if (options != null) {
      json['options'] = options;
    }

    return json;
  }
}
