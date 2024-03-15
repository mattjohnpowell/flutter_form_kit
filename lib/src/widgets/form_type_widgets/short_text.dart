import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class ShortText extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final String? initialData; // Add this line
  const ShortText({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
    this.initialData, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use initialData to initialize the controller if it's not already initialized
    if (initialData != null && controller.text.isEmpty) {
      controller.text = initialData!;
    }
    final textTheme = Theme.of(context).textTheme;
    final themeColor = FlutterFormDetails.of(context).themeColor;

    return TextField(
      onChanged: onChanged,
      controller: controller,
      onSubmitted: onSubmitted,
      style: textTheme.headlineMedium,
      cursorColor: themeColor,
      decoration: InputDecoration(
          hintText: "Type your answer here...",
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: themeColor))),
    );
  }
}
