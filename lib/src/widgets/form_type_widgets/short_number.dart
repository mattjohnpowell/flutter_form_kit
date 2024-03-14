import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class ShortNumber extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController controller;

  const ShortNumber({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  State<ShortNumber> createState() => _ShortNumberState();
}

class _ShortNumberState extends State<ShortNumber> {
  late bool _isValid;

  @override
  void initState() {
    super.initState();
    _isValid = true; // Initial state is valid
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final themeColor = FlutterFormDetails.of(context).themeColor;

    return TextField(
      onChanged: (value) {
        // Update the valid state based on the current input
        setState(() {
          _isValid = _isValidNumber(value) && _isWithinRange(value, 0, 272);
        });
        // If the current input is valid, call the onChanged callback
        if (_isValid) {
          widget.onChanged(value);
        }
      },
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      style: textTheme.headlineMedium,
      cursorColor: themeColor,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: "Type your number here...",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _isValid ? themeColor : Colors.red),
        ),
        // Additional visual feedback for invalid input
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: _isValid ? themeColor : Colors.red),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _isValid ? themeColor : Colors.red),
        ),
      ),
    );
  }

  bool _isValidNumber(String value) {
    final numberRegExp = RegExp(r'^\d*\.?\d+$');
    return numberRegExp.hasMatch(value);
  }

  bool _isWithinRange(String value, double min, double max) {
    if (!_isValidNumber(value)) return false;
    final number = double.parse(value);
    return number >= min && number <= max;
  }
}
