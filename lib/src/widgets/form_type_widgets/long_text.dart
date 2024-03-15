import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class LongText extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController? controller;
  final String? initialData; // Optional initial data

  const LongText({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.controller,
    this.initialData,
  }) : super(key: key);

  @override
  State<LongText> createState() => _LongTextState();
}

class _LongTextState extends State<LongText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize _controller with widget.controller or create a new one with initialData
    _controller = widget.controller ?? TextEditingController(text: widget.initialData);
  }

  @override
  void dispose() {
    // Dispose the created _controller if the widget didn't provide a controller
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeColor = FlutterFormDetails.of(context).themeColor;

    return TextFormField(
      onChanged: widget.onChanged,
      controller: _controller,
      onFieldSubmitted: widget.onSubmitted,
      style: textTheme.headlineMedium,
      cursorColor: themeColor,
      decoration: InputDecoration(
          hintText: "Type your answer here...",
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: themeColor))),
    );
  }
}
